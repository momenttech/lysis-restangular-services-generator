import { Injectable } from '@angular/core';
import { BackendService } from './backend.service';
import { {{ ucc resource.title }} } from '{{ classPath }}/{{ ucc resource.title }}';

@Injectable()
export class {{ ucc resource.name }}Service extends BackendService<{{ ucc resource.title }}> {
  protected get resource() { return '{{ resource.name }}'; }
  protected get class() { return {{ ucc resource.title }}; }

}
