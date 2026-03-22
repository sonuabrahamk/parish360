class Permissions {
  final DataOwner dataOwner;
  final Modules modules;

  Permissions({
    required this.dataOwner,
    required this.modules,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) {
    return Permissions(
      dataOwner: DataOwner(
        diocese: List<String>.from(json['data_owner']['diocese'] as List),
        parish: List<String>.from(json['data_owner']['parish'] as List),
        forane: List<String>.from(json['data_owner']['forane'] as List),
      ),
      modules: Modules(
        create: List<String>.from(json['modules']['create'] as List),
        view: List<String>.from(json['modules']['view'] as List),
        edit: List<String>.from(json['modules']['edit'] as List),
        delete: List<String>.from(json['modules']['delete'] as List),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data_owner': {
        'diocese': dataOwner.diocese,
        'parish': dataOwner.parish,
        'forane': dataOwner.forane,
      },
      'modules': {
        'create': modules.create,
        'view': modules.view,
        'edit': modules.edit,
        'delete': modules.delete,
      },
    };
  }
}

class DataOwner {
  final List<String> diocese;
  final List<String> parish;
  final List<String> forane;

  DataOwner({
    required this.diocese,
    required this.parish,
    required this.forane,
  });
}

class Modules {
  final List<String> create;
  final List<String> view;
  final List<String> edit;
  final List<String> delete;

  Modules({
    required this.create,
    required this.view,
    required this.edit,
    required this.delete,
  });
}