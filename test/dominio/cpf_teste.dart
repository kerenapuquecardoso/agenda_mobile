import 'package:eliane_noivas_mobile/dominio/cpf.dart';
import 'package:flutter_test/flutter_test.dart';


main(){
 
  group('CPF', (){
      group('[e03]  CPF - não pode ser vazio; ', (){
        CPF cpf = CPF('858.827.500-75');
        test('teste cpf não vazio', (){
          expect(()=>cpf.eVazio('858.827.500-75'), returnsNormally);
        });
        test('[e04] CPF - deve possuir 11 números', (){
          expect(()=>cpf.eVazio(''), throwsException);
        });
      });


      group('[e04]  CPF - deve possuir 11 números', (){
        test('teste com 11 números', (){
          expect(CPF('858.827.500-75').eOnzeNumeros(), true);
        });
        test('teste com 10 números', (){
          expect(()=>CPF('858.827.500-7').eOnzeNumeros(), throwsException);
        });
        test('teste com 13 números', (){
          expect(()=>CPF('858.827.500-714').eOnzeNumeros(), throwsException);
        });
      });


      group('[e05]  CPF - verificar se números são diferentes', (){
        test('teste com números diferentes', (){
          expect(CPF('858.827.500-75').eNumeroDiferente(), true);
        });
        test('teste com 1 número diferente', (){
          expect(CPF('111.111.115-11').eNumeroDiferente(), true);
        });
        test('teste com números iguais', (){
          expect(()=>CPF('111.111.111-11').eNumeroDiferente(), throwsException);
        });
      });
      group('[e06]  CPF – verificar os dígitos verificadores', (){
        test('teste com dígitos corretos', (){
          expect(CPF('858.827.500-75').eDigitoCorreto(), true);
        });
        test('teste com primeiro digito errado', (){
          expect(()=>CPF('858.827.500-05').eDigitoCorreto(), throwsException);
        });
        test('teste com segundo dígito errado', (){
          expect(()=>CPF('858.827.500-76').eDigitoCorreto(), throwsException);
        });
      });
  });
}
