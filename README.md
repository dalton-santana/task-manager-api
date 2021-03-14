##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby 2.4.0
- Rails 6.x
- MySQL

##### 1. Check out the repository

```bash
git clone git@github.com:dalton-santana/task-manager-api.git
cd task-manager-api
```

##### 2. Edit database.yml file

Edit the sample database.yml file and edit the database configuration as required.

```bash
cd config/database.yml
```

##### 3. Install dependencies

Run the following commands to create and setup the database.

```ruby
bundle install
```

##### 4. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create db:migrate db:seed
```

##### 5. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails server
```

And now you can visit the site with the URL http://localhost:3000


##### 6. Tests 
 "Os testes foi a parte que tive mais dificuldade para colocar em prática por causa do tempo de estudo dessa etapa, foquei em desenvolver a API com os requisitos necessários do desafio." 


##### 7. Routes (Insomnia)

[Download](https://drive.google.com/file/d/16EFd4QSpE8DO7nQ397NDMaEpIt8KFGtl/view?usp=sharing)


