import { Injectable } from '@angular/core';
import { BackendService } from './backend.service';
import { {{ ucc resource.title }} } from '{{ classPath }}';
//import { Observable } from 'rxjs/Observable';

@Injectable()
export class {{ ucc resource.name }}Service extends BackendService<{{ ucc resource.title }}> {
  protected get resource() { return {{ ucc resource.title }}._resource; }
  protected get class() { return {{ ucc resource.title }}; }

}
