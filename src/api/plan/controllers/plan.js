// ./src/api/plan/controllers/plan.js

'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

// This helper function does not need changes. It correctly gathers the data.
const getInheritedAttributes = (plan, plansMap, cache) => {
  if (cache.has(plan.id)) {
    return cache.get(plan.id);
  }

  let finalFeatures = new Map();
  let finalEntitlements = new Map();

  if (plan.inherit_from?.id) {
    const parentPlan = plansMap.get(plan.inherit_from.id);
    if (parentPlan) {
      const parentAttributes = getInheritedAttributes(parentPlan, plansMap, cache);
      finalFeatures = new Map(parentAttributes.features);
      finalEntitlements = new Map(parentAttributes.entitlements);
    }
  }

  plan.features.forEach(feature => {
    finalFeatures.set(feature.id, feature);
  });

  plan.plan_ent_links.forEach(link => {
    if (link.entitlement) {
      finalEntitlements.set(link.entitlement.slug, {
        id: link.entitlement.id,
        name: link.entitlement.name,
        slug: link.entitlement.slug,
        isMetered: link.entitlement.ismetered,
        limit: link.limitOverride !== null ? link.limitOverride : link.entitlement.defaultlimit,
        resetPeriod: link.entitlement.resetPeriod,
      });
    }
  });

  const result = { features: finalFeatures, entitlements: finalEntitlements };
  cache.set(plan.id, result);
  return result;
};


module.exports = createCoreController('api::plan.plan', ({ strapi }) => ({
  async findAllWithDetails(ctx) {
    try {
      const allPlans = await strapi.entityService.findMany('api::plan.plan', {
        sort: { order: 'asc' },
        populate: {
          features: true,
          plan_ent_links: { populate: { entitlement: true } },
          inherit_from: true,
          // --- CHANGE 1: Populate the child plans relation ---
          childPlans: true,
        },
      });

      const plansMap = new Map(allPlans.map(p => [p.id, p]));
      const inheritanceCache = new Map();

      const formattedPlans = allPlans.map(plan => {
        const { features, entitlements } = getInheritedAttributes(plan, plansMap, inheritanceCache);

        const finalFeaturesList = Array.from(features.values()).sort((a, b) => a.order - b.order);
        const finalEntitlementsList = Array.from(entitlements.values());

        return {
          id: plan.id,
          attributes: {
            name: plan.name,
            productId: plan.productId,
            order: plan.order,
            sale: {
              productId: plan.saleProductId,
              startDate: plan.saleStartDate,
              endDate: plan.saleEndDate,
            },
            features: {
              data: finalFeaturesList.map(feature => ({
                id: feature.id,
                attributes: {
                  name: feature.feature,
                  order: feature.order,
                },
              })),
            },
            entitlements: {
              data: finalEntitlementsList.map(ent => ({
                id: ent.id,
                attributes: {
                  name: ent.name,
                  slug: ent.slug,
                  isMetered: ent.isMetered,
                  limit: ent.limit,
                  resetPeriod: ent.resetPeriod,
                },
              })),
            },
            // --- CHANGE 2: Add inheritance data to the response ---
            inherit_from: plan.inherit_from ? {
              data: {
                id: plan.inherit_from.id,
                attributes: {
                  name: plan.inherit_from.name,
                  productId: plan.inherit_from.productId,
                }
              }
            } : null,
            childPlans: {
              data: (plan.childPlans || []).map(child => ({
                id: child.id,
                attributes: {
                  name: child.name,
                  productId: child.productId,
                }
              }))
            },
          },
        };
      });
      
      return { data: formattedPlans, meta: {} };

    } catch (err) {
      strapi.log.error('Error in findAllWithDetails plan controller:', err);
      ctx.internalServerError('An error occurred while fetching plans.');
    }
  },

  async findOneWithDetails(ctx) {
    try {
      const { id } = ctx.params;
      const plansMap = new Map();
      let currentPlanId = parseInt(id, 10);

      while (currentPlanId && !plansMap.has(currentPlanId)) {
        const plan = await strapi.entityService.findOne('api::plan.plan', currentPlanId, {
          populate: {
            features: true,
            plan_ent_links: { populate: { entitlement: true } },
            inherit_from: true,
            // --- CHANGE 3: Populate the child plans relation ---
            childPlans: true,
          },
        });
        if (!plan) {
          if (currentPlanId === parseInt(id, 10)) return ctx.notFound('Plan not found.');
          strapi.log.warn(`Broken inheritance chain: Plan ID ${currentPlanId} not found.`);
          break;
        }
        plansMap.set(plan.id, plan);
        currentPlanId = plan.inherit_from ? plan.inherit_from.id : null;
      }

      const targetPlan = plansMap.get(parseInt(id, 10));
      if (!targetPlan) return ctx.notFound('Plan not found.');

      const inheritanceCache = new Map();
      const { features, entitlements } = getInheritedAttributes(targetPlan, plansMap, inheritanceCache);
      
      const finalFeaturesList = Array.from(features.values()).sort((a, b) => a.order - b.order);
      const finalEntitlementsList = Array.from(entitlements.values());

      const formattedPlan = {
        id: targetPlan.id,
        attributes: {
          name: targetPlan.name,
          productId: targetPlan.productId,
          order: targetPlan.order,
          sale: {
            productId: targetPlan.saleProductId,
            startDate: targetPlan.saleStartDate,
            endDate: targetPlan.saleEndDate,
          },
          features: {
            data: finalFeaturesList.map(feature => ({
              id: feature.id,
              attributes: {
                name: feature.feature,
                order: feature.order,
              },
            })),
          },
          entitlements: {
            data: finalEntitlementsList.map(ent => ({
              id: ent.id,
              attributes: {
                name: ent.name,
                slug: ent.slug,
                isMetered: ent.isMetered,
                limit: ent.limit,
                resetPeriod: ent.resetPeriod,
              },
            })),
          },
          // --- CHANGE 4: Add inheritance data to the response ---
          inherit_from: targetPlan.inherit_from ? {
            data: {
              id: targetPlan.inherit_from.id,
              attributes: {
                name: targetPlan.inherit_from.name,
                productId: targetPlan.inherit_from.productId,
              }
            }
          } : null,
          childPlans: {
            data: (targetPlan.childPlans || []).map(child => ({
              id: child.id,
              attributes: {
                name: child.name,
                productId: child.productId,
              }
            }))
          },
        },
      };

      return { data: formattedPlan, meta: {} };

    } catch (err) {
      strapi.log.error('Error in findOneWithDetails plan controller:', err);
      ctx.internalServerError('An error occurred while fetching the plan.');
    }
  },
}));