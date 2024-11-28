import 'package:eliane_noivas_mobile/dominio/dto/dto_traje_locacao.dart';
import 'package:eliane_noivas_mobile/dominio/traje_locacao.dart';

class DtoLocacao{
  dynamic? id;
  dynamic? cliente_id;
  dynamic? funcionario_id;
  DateTime? data_locacao;
  DateTime? data_devolucao;
  DateTime? data_retirada;
  String? status;
  double? valor_total;
  late List<DtoTrajeLocacao> trajes;

  DtoLocacao({this.id, this.cliente_id, this.funcionario_id, this.data_locacao, this.data_devolucao, this.data_retirada, this.status, this.valor_total, List<DtoTrajeLocacao>? trajes,
  });
}