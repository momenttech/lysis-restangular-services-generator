// This file should not be modified, as it can be overwritten by the generator.

{{#each resources}}
import { {{ ucc name }}Service } from './{{ ucc name }}.service';
{{/each}}


export {
  {{#each resources}}
  {{ ucc name }}Service,
  {{/each}}
}
