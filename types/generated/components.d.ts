import type { Schema, Attribute } from '@strapi/strapi';

export interface AFeatures extends Schema.Component {
  collectionName: 'components_a_features';
  info: {
    displayName: 'features';
    icon: 'check';
    description: '';
  };
  attributes: {};
}

declare module '@strapi/types' {
  export module Shared {
    export interface Components {
      'a.features': AFeatures;
    }
  }
}
