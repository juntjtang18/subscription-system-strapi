'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

// ... (The getInheritedAttributes helper function remains the same)
const getInheritedAttributes = (plan, plansMap, cache) => {
  // If we have already calculated this plan's inheritance, return the cached result.
  if (cache.has(plan.id)) {
    return cache.get(plan.id);
  }

  // Maps to hold the final merged attributes.
  let finalFeatures = new Map();
  let finalEntitlements = new Map();

  // --- Recursive Step ---
  // If this plan has a parent, first get the parent's fully resolved attributes.
  if (plan.inherit_from && plan.inherit_from.id) {
    const parentPlan = plansMap.get(plan.inherit_from.id);
    if (parentPlan) {
      const parentAttributes = getInheritedAttributes(parentPlan, plansMap, cache);
      finalFeatures = new Map(parentAttributes.features);
      finalEntitlements = new Map(parentAttributes.entitlements);
    }
  }

  // --- Merge Step ---
  // Now, merge this plan's own attributes. They will override any from the parent.
  plan.features.forEach(feature => {
    finalFeatures.set(feature.id, feature);
  });

  plan.plan_ent_links.forEach(link => {
    if (link.entitlement) {
      finalEntitlements.set(link.entitlement.slug, {
        name: link.entitlement.name,
        slug: link.entitlement.slug,
        isMetered: link.entitlement.ismetered,
        limit: link.limitOverride !== null ? link.limitOverride : link.entitlement.defaultlimit,
        resetPeriod: link.entitlement.resetPeriod,
      });
    }
  });
  
  const result = { features: finalFeatures, entitlements: finalEntitlements };
  
  // Cache the result for this plan ID before returning.
  cache.set(plan.id, result);
  
  return result;
};


module.exports = createCoreController('api::plan.plan', ({ strapi }) => ({
  async findAllWithDetails(ctx) {
    try {
      // 1. Fetch ALL plans, now sorted by the 'order' field.
      const allPlans = await strapi.entityService.findMany('api::plan.plan', {
        // 👇 ADD THIS LINE TO SORT THE PLANS
        sort: { order: 'asc' }, 
        populate: {
          features: true,
          plan_ent_links: {
            populate: {
              entitlement: true,
            },
          },
          inherit_from: true,
        },
      });

      // 2. Create a Map for efficient lookups
      const plansMap = new Map(allPlans.map(p => [p.id, p]));
      
      // 3. Create a cache for memoization
      const inheritanceCache = new Map();

      // 4. Process each plan. The final array will maintain the sorted order.
      const formattedPlans = allPlans.map(plan => {
        const { features, entitlements } = getInheritedAttributes(plan, plansMap, inheritanceCache);

        const finalFeaturesList = Array.from(features.values())
          .map(feature => ({
            name: feature.feature,
            order: feature.order,
          }))
          .sort((a, b) => a.order - b.order);

        const finalEntitlementsList = Array.from(entitlements.values());
        
        return {
          id: plan.id,
          name: plan.name,
          productId: plan.productId,
          order: plan.order, // You might want to include the order in the response
          sale: {
            productId: plan.saleProductId,
            startDate: plan.saleStartDate,
            endDate: plan.saleEndDate,
          },
          features: finalFeaturesList,
          entitlements: finalEntitlementsList,
        };
      });

      // 5. Return the sanitized and formatted response
      return this.transformResponse(formattedPlans);

    } catch (err) {
      strapi.log.error('Error in recursive plan controller:', err);
      ctx.internalServerError('An error occurred while fetching plans.');
    }
  },
}));