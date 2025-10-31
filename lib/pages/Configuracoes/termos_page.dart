import 'package:flutter/material.dart';

class TermosPage extends StatefulWidget {
  const TermosPage({super.key});

  @override
  State<TermosPage> createState() => _TermosPageState();
}

class _TermosPageState extends State<TermosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Termos de serviço')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Aplicativo Educacional para Formação Docente em Libras e Comunidade Surda',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                '1. Aceitação dos Termos\nAo acessar ou utilizar este aplicativo (“App”), '
                'você concorda integralmente com os presentes Termos de Serviço. '
                'Caso não concorde com qualquer cláusula, deverá interromper o uso imediatamente.',
              ),
              SizedBox(height: 10),
              Text(
                '2. Objetivo do App\nO App tem como finalidade oferecer conteúdos, atividades e recursos '
                'didáticos para a formação de professores da rede estadual de ensino, com foco no ensino '
                'e na compreensão da Língua Brasileira de Sinais (Libras) e da cultura da comunidade surda.',
              ),
              SizedBox(height: 10),
              Text(
                '3. Público-Alvo\nO uso do App é destinado exclusivamente a professores, coordenadores pedagógicos '
                'e demais profissionais de educação vinculados à rede estadual de ensino, mediante cadastro e '
                'autorização prévia da Secretaria de Educação.',
              ),
              SizedBox(height: 10),
              Text(
                '4. Cadastro e Conta do Usuário\nPara utilizar o App, é necessário realizar um cadastro com dados '
                'pessoais e institucionais corretos e atualizados. O usuário é responsável por manter a confidencialidade '
                'de sua senha e credenciais de acesso. O uso da conta é pessoal e intransferível.',
              ),
              SizedBox(height: 10),
              Text(
                '5. Uso Permitido\nÉ permitido ao usuário: Acessar aulas, vídeos, materiais de estudo e exercícios '
                'disponíveis no App; Utilizar os recursos para fins exclusivamente educacionais; Participar de atividades, '
                'avaliações e fóruns de discussão propostos.',
              ),
              SizedBox(height: 10),
              Text(
                '6. Uso Proibido\nO usuário não poderá: Reproduzir, copiar, distribuir ou comercializar conteúdos do App '
                'sem autorização expressa; Utilizar o App para fins que não sejam educacionais; Compartilhar credenciais '
                'de acesso com terceiros; Inserir informações falsas, ofensivas ou discriminatórias no ambiente virtual.',
              ),
              SizedBox(height: 10),
              Text(
                '7. Direitos Autorais e Propriedade Intelectual\nTodos os conteúdos, materiais audiovisuais, textos, imagens '
                'e recursos interativos disponibilizados no App são protegidos por leis de propriedade intelectual, sendo de '
                'titularidade da Secretaria de Educação ou de seus parceiros autorizados. É proibida qualquer reprodução ou uso não autorizado.',
              ),
              SizedBox(height: 10),
              Text(
                '8. Proteção de Dados e Privacidade\nOs dados pessoais e acadêmicos coletados serão utilizados apenas para '
                'fins de autenticação, gestão de participação e emissão de certificados. O App segue as diretrizes da Lei Geral '
                'de Proteção de Dados (Lei nº 13.709/2018 – LGPD). Não serão compartilhadas informações pessoais com terceiros '
                'sem consentimento, exceto quando exigido por lei.',
              ),
              SizedBox(height: 10),
              Text(
                '9. Disponibilidade e Alterações\nA Secretaria de Educação reserva-se o direito de: Alterar ou atualizar '
                'conteúdos e funcionalidades sem aviso prévio; Suspender temporariamente o funcionamento do App para manutenção '
                'ou melhorias; Encerrar o serviço, mediante aviso prévio, preservando o acesso aos certificados já emitidos.',
              ),
              SizedBox(height: 10),
              Text(
                '10. Responsabilidades do Usuário\nO usuário é responsável por: Utilizar o App de forma ética e respeitosa; '
                'Garantir que seu dispositivo possua os requisitos técnicos mínimos; Zelar pela veracidade das informações fornecidas.',
              ),
              SizedBox(height: 10),
              Text(
                '11. Responsabilidades do Fornecedor\nA Secretaria de Educação compromete-se a: Fornecer suporte técnico básico; '
                'Garantir a integridade dos conteúdos disponibilizados; Manter a segurança da plataforma.',
              ),
              SizedBox(height: 10),
              Text(
                '12. Disposições Gerais\nEstes Termos poderão ser atualizados periodicamente. A versão mais recente estará sempre '
                'disponível no App. O uso contínuo após alterações implica concordância com os novos termos.',
              ),
              SizedBox(height: 10),
              Text(
                '13. Foro\nFica eleito o foro da Comarca da capital do estado como competente para dirimir quaisquer questões '
                'decorrentes destes Termos, com renúncia a qualquer outro, por mais privilegiado que seja.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
