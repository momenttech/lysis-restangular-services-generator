# Lysis Restangular services generator

## Overview

This generator creates Restangular services to handle CRUD actions.

## Samples

### Backend service generic class

The `backend-service.ts` file is created in the services directory.

It uses the default Restangular service.

It provides many methods:

- `get(id: any): Observable<T>`
- `getAll(pageNumber?: number, criterias: Object = {}): Observable<T[]>`
- `add(item: T): Observable<T>`
- `update(item: T): Observable<T>`
- `remove(item: T): Observable<any>`

Where `<T>` is the result class, maybe from TypeScript classes generator

Two helper methods can be called directly, or used in inherited services:

- `getAllBy(field: string, value: any, pageNumber?: number, criterias: Object = {}, alias: string = this.resource): Observable<T[]>`
- `getAllByFilter(filter: string, value: any, pageNumber?: number, criterias: Object = {}): Observable<T[]>`

### Rest services

A service class is created for each resource.

Example of service to handle books, in the generated file `Books.service.ts`:

```
import { Injectable } from '@angular/core';
import { BackendService } from './backend.service';
import { Books } from '../classes/Books';

@Injectable()
export class BooksService extends BackendService<Books> {
  protected get resource() { return 'books'; }
  protected get class() { return Books; }

}
```

### Basic usage

In a controller, to get books:

```
import { Component, OnInit } from '@angular/core';

import { BooksService } from '../backend/services';
import { Book } from '../backend/classes';

@Component({
  selector: 'app-books-list',
  templateUrl: './books-list.component.html',
  styleUrls: ['./books-list.component.css']
})

export class BooksListComponent implements OnInit {
  books: Array<Book> = [];

  constructor(
    private booksService : BooksService
  ) {}

  ngOnInit() {
    this.booksService.getAll().subscribe(books => {
      this.books = this.books.concat(books);
    });
  }
}
```

### Extend services

As services are simple, and do contain nothing more than the resource class and name, it is not overwritten in further generations.

This allows you to update services to add helper methods.

For example, this method extends the generated `ReviewService` to add a method to easily get reviews per book.

```
import { Injectable } from '@angular/core';
import { BackendService } from './backend.service';
import { Reviews } from '../classes/Reviews';

@Injectable()
export class ReviewsService extends BackendService<Reviews> {
  protected get resource() { return 'reviews'; }
  protected get class() { return Reviews; }

  getByBookId(id: number, pageNumber?: number, criterias: Object = {}): Observable<Reviews[]> {
    return this.getAllByFilter('book.id', id, pageNumber, criterias);
  }
}
```

The request URI is for example: `http://my-backend/reviews?book.id=5`.

However, the same result is reached when using `getAllByFilter` directly in the controller, without additional method:

```
this.reviewsService.getAllByFilter('book.id', 5);
```

### Index file

The index file is the one to include in the application controller, services, ... to use services.

It should not be modified, as it is overwritten during further generations.

## Use

### Prerequisites

If it is not already done, install api-lysis globally and as dev dependency:

```
npm install api-lysis -g
npm install api-lysis --save-dev
```

### Install this generator

Install this generator:

```
npm install lysis-restangular-services-generator --save-dev
```

### Restangular configuration

Install the Restangular config. But how?

This will be available soon.

### Configuration

Configuration sample:

```
apis:
  http://localhost:8000:
    basePath: 'my-backend'
    hydraPrefix: 'hydra:'
    generators:
      lysis-restangular-services-generator:
        dir: 'services'
        classPath: '../classes'
```

Services files are generated in `my-backend/services`.

If `dir` is not set, the default value is `backend-services`.

`classPath` is the path to class files. By default it is set to `../backend-classes`.
