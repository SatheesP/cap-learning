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
- Already if you are in project folder then  
`cds init`  
- If not  
`cds init <proj folder>`  
- then for Node.js facet  
`cds add ndoejs` (or) initial itself `cds init --add nodejs` then  
`npm install` (or) `npm i` to install dependencies
without adding Node.js facet and npm install, when issuing `cds watch`  
in terminal window you may get the error "**ERR_UNSUPPORTED_ESM_URL_SCHEME**"
- `cds watch` looking for domain model / service model / annotation cds files
    ```
    cds serve all --with-mocks --in-memory? 
    ( live reload enabled for browsers ) 

            ___________________________
    

        No models found in db/,srv/,app/,app/*.
        Waiting for some to arrive...
    ```

## Add a domain / data model
- Add `schema.cds` file to folder  `/db`
- Define a simple entity `Books` as part of the namespace 'my.bookshop'
    ```cds
    namespace my.bookshop;

    entity Books {
        key ID : Integer;
        title  : String(100);
        descr  : String(255);
        author : String(100);
    }
    ```
- Terminal window issue the command `cds watch`
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