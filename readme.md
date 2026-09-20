# Getting Started

Welcome to your new CAP project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`readme.md` | this getting started guide

## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start with your domain model, in a CDS file in `db/`

## Learn More

Learn more at <https://cap.cloud.sap>.

## CAP Node.js Project Setup

Follow these steps to bootstrap a new CAP project with the Node.js runtime.

**1. Initialize the project**

If you're already inside your project folder, run:
```
cds init
```
Otherwise, initialize a new folder directly:
```
cds init <proj folder>
```

**2. Add the Node.js facet**

Add Node.js support to an existing project:
```
cds add nodejs
```
Or combine both steps by adding Node.js during initialization:
```
cds init --add nodejs
```

**3. Install dependencies**

```
npm install
```

> **Note:** Skipping the Node.js facet or the `npm install` step will cause `cds watch` to fail with the error `ERR_UNSUPPORTED_ESM_URL_SCHEME`.

**4. Start the development server**

Once set up, `cds watch` continuously scans your project for domain models, service definitions, and annotation files. If none are found yet, it will simply wait until you add one:
```
cds serve all --with-mocks --in-memory? 
( live reload enabled for browsers ) 

        ___________________________


    No models found in db/,srv/,app/,app/*.
    Waiting for some to arrive...
```

## Add a domain / data model

Domain models describe the structure of your business data using CDS entities. Let's define a simple one for the bookshop.

**1. Create the schema file**

Add a `schema.cds` file inside the `/db` folder — this is where CAP expects your domain models to live.

**2. Define an entity**

Declare a `Books` entity within the `my.bookshop` namespace:
```cds
namespace my.bookshop;

entity Books {
    key ID : Integer;
    title  : String(100);
    descr  : String(255);
    author : String(100);
}
```

**3. Reload the watcher**

With `cds watch` still running (or freshly started) in your terminal, it automatically picks up the new model, loads it, and spins up an in-memory SQLite database for you:
```
        ___________________________

[cds] - loaded model from 1 file(s):

db\schema.cds

[cds] - using bindings from: { registry: '~/.cds-services.json' }
[cds] - connect to db > sqlite { url: ':memory:' }
/> successfully deployed to in-memory database. 

[cds] - server listening on { url: 'http://localhost:4004' }
[cds] - server v10.1.1 launched in 360 ms
[cds] - [ terminate with ^C ]


    No service definitions found in loaded models.
    Waiting for some to arrive...
```

> **Note:** At this point, your data model exists but isn't exposed anywhere yet. That message about "no service definitions" is expected — you'll fix that in the next step by exposing this entity through a service.

## Add a service model

A domain model on its own isn't accessible to consumers — you need to expose it through a service. Let's create one for our `Books` entity.

**1. Create the service file**

Add a `catalog-service.cds` file inside the `/srv` folder.

**2. Expose the entity**

Define a service that projects the `Books` entity from your domain model. By default, CAP serves this as an OData V4 service:
```
using { my.bookshop as db } from '../db/schema';

service CatalogService {
    entity Books as projection on db.Books;
}
```

**3. Check the watcher output**

`cds watch` picks up the change automatically, loads both model files, and starts serving the service at runtime:
```
        ___________________________

[cds] - loaded model from 2 file(s):

srv\catalog-service.cds
db\schema.cds

[cds] - using bindings from: { registry: '~/.cds-services.json' }
[cds] - connect to db > sqlite { url: ':memory:' }
/> successfully deployed to in-memory database. 

[cds] - using auth strategy {
kind: 'mocked',
impl: 'node_modules\\@sap\\cds\\lib\\srv\\middlewares\\auth\\basic-auth.js'
}
[cds] - serving CatalogService {
at: [ '/odata/v4/catalog' ],
decl: 'srv\\catalog-service.cds:3',
impl: 'node_modules\\@sap\\cds\\srv\\app-service.js'
}
[cds] - server listening on { url: 'http://localhost:4004' }
[cds] - server v10.1.1 launched in 4620 ms
[cds] - [ terminate with ^C ]
```

**4. Explore the service**

Open <http://localhost:4004> in your browser or `Ctrl+Shift+P`, type **Browser: Open Itegrated Browser**, press Enter, then type the URL (e.g. http://localhost:4004) when prompted. . You'll find the following links:

Service document | Metadata | Entity sets | Fiori Preview
-------|------|---------|--------
odata/v4/catalog | $metadata | Books | Fiori preview

Note that the `Books` entity set is still empty at this point — no data has been added yet.

**5. Seed some sample data**

CAP makes it easy to generate CSV files for your entities:

- Generate a CSV file with headers only (no rows):
  ```
  cds add data
  ```
- Generate a CSV file with sample data, added to `/db/data` by default. Since anything in this folder is deployed all the way to production, only use it for master data, customizing, and configuration-style content:
  ```
  cds add data --records 10
  ```
  (or the shorthand: `cds add data -n 10`)
- If you only need data for local development or testing — and don't want it deployed to production — generate it into `/test/data` instead:
  ```
  cds add data -n 10 -o test/data
  ```