Do not forget to add this content to app-module.ts.

1) Import:

import {
  {{#each resources}}
  {{ ucc name }}Service,
  {{/each}}
} from './{{ basePath }}';

2) In providers list:

providers: [
  {{#each resources}}
  {{ ucc name }}Service,
  {{/each}}
]

Take a look to the generator documentation for further details:
https://github.com/momenttech/lysis-restangular-services-generator
