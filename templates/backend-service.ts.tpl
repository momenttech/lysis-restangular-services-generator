import { Injectable } from '@angular/core';
import { Restangular } from 'ngx-restangular';
import { Observable } from 'rxjs/Observable';

@Injectable()
export abstract class BackendService<T> {
  protected abstract get resource(): string;
  protected abstract get class(): any;
  protected idField: string = 'id';

  constructor(protected restangular: Restangular) {
    var baseItem = new (this.class)();
    var idField = this.idField;

    this.restangular.provider.addElementTransformer(this.resource, function(item) {
      if (!item[idField]) return item;
      // add resource class methods to the item, to turn it into a resource-object-like
      for (let method in baseItem) {
        if(typeof baseItem[method] == 'function') {
          item[method] = baseItem[method];
        }
      }
      return item;
    });
  }

  setIdField(idField: string): void {
    this.idField = idField;
  }

  makeCriterias(pageNumber: number, criterias: Object): Object {
    if (!criterias) criterias = {};
    if (pageNumber) criterias['page'] = pageNumber;
    return criterias;
  }

  get(id: any): Observable<T> {
    return this.restangular.one(this.resource, id).get();
  }

  getAll(pageNumber?: number, criterias: Object = {}): Observable<T[]> {
    return this.restangular.all(this.resource).getList(this.makeCriterias(pageNumber, criterias));
  }

  getAllBy(field: string, value: any, pageNumber?: number, criterias: Object = {}, alias: string = this.resource): Observable<T[]> {
    return this.restangular.one(field, value).all(alias).getList(this.makeCriterias(pageNumber, criterias));
  }

  getAllByFilter(filter: string, value: any, pageNumber?: number, criterias: Object = {}): Observable<T[]> {
    criterias[filter] = value;
    return this.getAll(pageNumber, criterias);
  }

  add(item: T): Observable<T> {
    return this.restangular.all(this.resource).post(item);
  }

  update(item: T): Observable<T> {
    return this.restangular.one(this.resource, item[this.idField]).customPUT(item);
  }

  remove(item: T): Observable<any> {
    return this.restangular.one(this.resource, item[this.idField]).remove();
  }
}
