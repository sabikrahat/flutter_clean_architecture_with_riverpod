
# Flutter Clean Architecture Template  

Welcome to our Flutter Clean Architecture template!  

In the world of software development, clean architecture has become a widely adopted standard across various tech stacks. It helps in creating scalable, testable, and maintainable applications. With this template, we aim to provide Flutter developers a structured and organized starting point for their projects while adhering to the *SOLID principles* of software design.  

## Key Features  
- **Riverpod**: Used for state management, ensuring reactive and efficient state updates.  
- **Hive**: Used for local storage, offering a lightweight and fast solution for data persistence.  
- **SOLID Principles**: Our primary focus is to maintain the SOLID principles throughout the codebase to ensure a clean and modular architecture.  

## Goals  
This template is designed to:  
- Simplify the process of following clean architecture in Flutter projects.  
- Provide a modular and extensible foundation for developers.  
- Encourage the best practices of software design and state management.  

## Contributions  
We welcome contributions from the community to make this template better and more robust. Whether it's improving the code, adding new features, or optimizing the current implementation, feel free to contribute!

## Authors

- https://www.github.com/sabikrahat > https://theflutterway.com | https://www.skytechbpo.com/ 

- https://github.com/Pritom-Shajed > https://impulsion.ae/ | https://www.skytechbpo.com/

- https://github.com/HasanAlHridoy > https://www.skytechbpo.com/

## Architecture

### Packages:

  dependencies:
    flutter_riverpod:
    go_router:

  
### Folder Structure:
```
  lib/
    │
    ├── core/
    │
    ├── data/
    │    │
    │    ├── models/
    │    │    ├── user_model.dart --> class UserModel extends UserEntity {} -> depends on lib/domain/entities folder
    │    │    └── other_model.dart --> class OtherModel extends OtherEntity {} -> depends on lib/domain/entities folder
    │    │
    │    ├── repositories/
    │    │    ├── user_repository.dart --> class UserRepositoryImpl implements UserRepository {} -> depends on ./datasources folder
    │    │    └── other_repository.dart --> class OtherRepositoryImpl implements OtherRepository {} -> depends on ./datasources folder
    │    │
    │    └── datasources/
    │         ├── remote/
    │         │    ├── user_remote_data_source.dart --> class UserRemoteSource {} -> independent file
    │         │    └── other_remote_data_source.dart --> class OtherRemoteSource {} -> independent file
    │         └── local/
    │              ├── user_local_data_source.dart --> class UserLocalSource {} -> independent file
    │              └── other_local_data_source.dart --> class OtherLocalSource {} -> independent file
    │
    ├── domain/
    │    │
    │    ├── entities/
    │    │    ├── user_entity.dart --> class UserEntity {} -> independent file
    │    │    └── other_entity.dart --> class OtherEntity {} -> independent file
    │    │
    │    ├── repositories/
    │    │    ├── user_repository.dart --> abstract interface class UserRepository {} -> independent file
    │    │    └── other_repository.dart --> abstract interface class OtherRepository {} -> independent file
    │    │
    │    └── usecases/
    │         ├── user_usecase.dart --> class UserUseCase {} -> depends on ./repositories folder
    │         └── other_usecase.dart --> class OtherUseCase {} -> depends on ./repositories folder
    │
    ├── presentation/
    │    │
    │    ├── riverpod/
    │    │    └── user_riverpod.dart -> depends on ./entities & ./repositories file
    │    │
    │    ├── components/
    │    │    ├── user_compoent_1.dart -> mostly depends on ./riverpod folder
    │    │    └── user_compoent_2.dart -> mostly depends on ./riverpod folder
    │    │
    │    ├── pages/
    │    │    └── user_page.dart -> mostly depends on ./riverpod & ./components folder
    │    │
    │    └── main.dart
    │
    ├── app.dart -> depends on ./app_routes folder
    │
    ├── app_routes.dart -> independent file
    │
    │
    └── main.dart -> depends on ./app file
```