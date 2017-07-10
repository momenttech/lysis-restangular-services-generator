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
