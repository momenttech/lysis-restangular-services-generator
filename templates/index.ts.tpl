{{#each resources}}
import { {{ ucc name }}Service } from './{{ ucc name }}.service';
{{/each}}


export {
  {{#each resources}}
  {{ ucc name }}Service,
  {{/each}}
}
