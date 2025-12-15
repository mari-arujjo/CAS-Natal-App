// rotas.dart
import 'package:app_cas_natal/nav.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20aula/aula_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20aula/cadastro_aula_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20aula/gestao_aula_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20curso/cadastro_curso_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20curso/curso_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20curso/gestao_curso_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20glossario/cadastro_glossario_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20glossario/gestao_glossario_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20users/cadastrar_user_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20users/gestao_users_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/Gestao%20users/user_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/admin_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/Admin/estatistica_admin_page.dart';
import 'package:app_cas_natal/pages/Cursos/Aula/lesson_content_page.dart';
import 'package:app_cas_natal/pages/Cursos/Aula/lesson_quiz_page.dart';
import 'package:app_cas_natal/pages/Cursos/Aula/lesson_video_page.dart';
import 'package:app_cas_natal/pages/Glossario/glossario_page.dart';
import 'package:app_cas_natal/pages/Glossario/sign_page.dart'; // Import adicionado
import 'package:app_cas_natal/pages/Configuracoes/config_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/editar_perfil_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/estatisticas_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/senha_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/sobre_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/termos_page.dart';
import 'package:app_cas_natal/pages/Cursos/detalhe_curso_page.dart';
import 'package:app_cas_natal/pages/Cursos/cursos_page.dart';
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/src/course/course_model.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/src/lesson/lesson_provider.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_cas_natal/pages/login_cadastro_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorCursos = GlobalKey<NavigatorState>(debugLabel: 'shellCursos');
final _rootNavigatorGlossario = GlobalKey<NavigatorState>(debugLabel: 'shellGlossario');
final _rootNavigatorConfiguracoes = GlobalKey<NavigatorState>(debugLabel: 'shellConfiguracoes');

final goRouterProvider = Provider<GoRouter>((ref){
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/cursos',
    navigatorKey: _rootNavigatorKey,

    redirect: (BuildContext context, GoRouterState state) async{
      final storage = ref.read(secureStorageProvider);
      final token = await storage.read(key: 'token');
      final isLoggedIn = token != null && token.isNotEmpty;

      final isGoingToLogin = state.matchedLocation == '/loginRegister';

      if (!isLoggedIn && !isGoingToLogin) return '/loginRegister';
      
      if (isLoggedIn && isGoingToLogin) return '/cursos';
      
      return null;
    },

    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationBarWidget(navigationShell: navigationShell);
        },

        branches: <StatefulShellBranch>[
          ////////////// BRANCH -> CURSOS
          StatefulShellBranch(
            navigatorKey: _rootNavigatorCursos,
            routes: [
              GoRoute(
                path: '/cursos',
                name: 'Cursos',
                builder: (context, state) {
                  return CursosPage(key: state.pageKey);
                },
                routes: [
                  GoRoute(
                    path: 'detalheCurso/:courseId',
                    name: 'DetalheCurso',
                    builder: (context, state) {
                      final courseId = state.pathParameters['courseId']!;
                      return DetalheCursoPage(
                        key: state.pageKey, 
                        courseId: courseId,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'video/:lessonId',
                        name: 'LessonVideo',
                        builder: (context, state) {
                          final lessonId = state.pathParameters['lessonId']!;
                          return Consumer(
                            builder: (context, ref, child) {
                              final lessonAsync = ref.watch(lessonDetailProvider(lessonId)); 
                              return lessonAsync.when(
                                loading: () => const Scaffold(body: Center(child: CarregandoWidget())),
                                error: (error, stack) => Scaffold(body: Center(child: Text('Erro ao carregar vídeo: $error'))),
                                data: (lesson) => LessonVideoPage(lesson: lesson, key: state.pageKey),
                              );
                            },
                          );
                        },
                      ),
                      GoRoute(
                        path: 'content/:lessonId',
                        name: 'LessonContent',
                        builder: (context, state) {
                          final lessonId = state.pathParameters['lessonId']!;
                          return Consumer(
                            builder: (context, ref, child) {
                              final lessonAsync = ref.watch(lessonDetailProvider(lessonId)); 
                              return lessonAsync.when(
                                loading: () => const Scaffold(body: Center(child: CarregandoWidget())),
                                error: (error, stack) => Scaffold(body: Center(child: Text('Erro ao carregar conteúdo: $error'))),
                                data: (lesson) => LessonContentPage(lesson: lesson, key: state.pageKey),
                              );
                            },
                          );
                        },
                      ),
                      GoRoute(
                        path: 'quiz/:lessonId',
                        name: 'LessonQuiz',
                        builder: (context, state) {
                          final lessonId = state.pathParameters['lessonId']!;
                          return Consumer(
                            builder: (context, ref, child) {
                              final lessonAsync = ref.watch(lessonDetailProvider(lessonId)); 
                              return lessonAsync.when(
                                loading: () => const Scaffold(body: Center(child: CarregandoWidget())),
                                error: (error, stack) => Scaffold(body: Center(child: Text('Erro ao carregar quiz: $error'))),
                                data: (lesson) => LessonQuizPage(lesson: lesson, key: state.pageKey),
                              );
                            },
                          );
                        },
                      ),
                    ]
                  ),
                ]
              ),
            ],
          ),

          ////////////// BRANCH -> GLOSSARIO
          StatefulShellBranch(
            navigatorKey: _rootNavigatorGlossario,
            routes: [
              GoRoute(
                path: '/glossario',
                name: 'Glossario',
                builder: (context, state) {
                  return GlossarioPage(key: state.pageKey);
                },
                routes: [ // Rota do Detalhe do Sinal adicionada
                  GoRoute(
                    path: 'sinal/:signId',
                    name: 'SinalDetalhe',
                    builder: (context, state) {
                      final signId = state.pathParameters['signId']!;
                      return SignPage(key: state.pageKey, signId: signId); 
                    },
                  ),
                ]
              ),
            ],
          ),

          ////////////// BRANCH -> CONFIGURAÇÕES
          StatefulShellBranch(
            navigatorKey: _rootNavigatorConfiguracoes,
            routes: [
              GoRoute(
                path: '/configuracoes',
                name: 'Configuracoes',
                builder: (context, state) {
                  return ConfiguracoesPage(key: state.pageKey);
                },
                routes: [
                  GoRoute(
                    path: '/editarPerfil',
                    name: 'EditarPerfil',
                    builder: (context, state) {
                      return EditarPerfilPage(key: state.pageKey);
                    },
                  ),
                  GoRoute(
                    path: '/estatisticas',
                    name: 'Estatisticas',
                    builder: (context, state) {
                      return EstatisticasPage(key: state.pageKey);
                    },
                  ),
                  GoRoute(
                    path: '/admin',
                    name: 'Admin',
                    builder: (context, state) {
                      return AdminPage(key: state.pageKey);
                    },
                    routes: [
                      GoRoute(
                        path: 'gestaoUsers',
                        name: 'GestaoUsers',
                        builder: (context, state) {
                          return GestaoUsersPage(key: state.pageKey);
                        },
                        routes: [
                          GoRoute(
                            path: 'cadastroUser',
                            name: 'CadastroUser',
                            builder: (context, state) {
                              return CadastrarUserPage(key: state.pageKey);
                            },
                          ),
                          GoRoute(
                            path: 'alterarUser',
                            name: 'AlterarUser',
                            builder: (context, state) {
                              return UserPage(key: state.pageKey);
                            },
                          )
                        ]
                      ),
                      GoRoute(
                        path: 'gestaoCurso',
                        name: 'GestaoCurso',
                        builder: (context, state) {
                          return GestaoCursoPage(key: state.pageKey);
                        },
                        routes: [
                          GoRoute(
                            path: 'cadastroCurso',
                            name: 'CadastroCurso',
                            builder: (context, state) {
                              return CadastroCursoPage(key: state.pageKey);
                            },
                          ),
                          GoRoute(
                            path: 'alterarCurso',
                            name: 'AlterarCurso',
                            builder: (context, state) {
                              final curso = state.extra as CourseModel;
                              return CursoPage(key: state.pageKey, curso: curso);
                            },
                          ),
                        ]
                      ),
                      GoRoute(
                        path: 'gestaoAula',
                        name: 'GestaoAula',
                        builder: (context, state) {
                          return GestaoAulaPage(key: state.pageKey);
                        },
                        routes: [
                          GoRoute(
                            path: 'cadastroAula',
                            name: 'CadastroAula',
                            builder: (context, state) {
                              return CadastroAulaPage(key: state.pageKey);
                            },
                          ),
                          GoRoute(
                            path: 'alterarAula',
                            name: 'AlterarAula',
                            builder: (context, state) {
                              final aula = state.extra as LessonModel;
                              return AulaPage(key: state.pageKey, aula: aula);
                            },
                          ),
                        ]
                      ),
                      GoRoute(
                        path: 'gestaoGlossario',
                        name: 'GestaoGlossario',
                        builder: (context, state) {
                          return GestaoGlossarioPage(key: state.pageKey);
                        },
                        routes: [
                          GoRoute(
                            path: 'cadastroGlossario',
                            name: 'CadastroGlossario',
                            builder: (context, state) {
                              return CadastroGlossarioPage(key: state.pageKey);
                            },
                          ),
                          GoRoute(
                            path: 'alterarGlossario',
                            name: 'AlterarGlossario',
                            builder: (context, state) {
                              return GlossarioPage(key: state.pageKey);
                            },
                          ),
                        ]
                      ),
                      GoRoute(
                        path: '/estatisticaAdmin',
                        name: 'EstatisticasAdmin',
                        builder: (context, state) {
                          return EstatisticasAdminPage(key: state.pageKey);
                        },
                      )
                    ]
                  ),
                  GoRoute(
                    path: '/redefinirSenha',
                    name: 'RedefinirSenha',
                    builder: (context, state) {
                      return RedefinirSenhaPage(key: state.pageKey);
                    },
                  ),
                  GoRoute(
                    path: '/sobre',
                    name: 'Sobre',
                    builder: (context, state) {
                      return SobrePage(key: state.pageKey);
                    },
                  ),
                  GoRoute(
                    path: '/termos',
                    name: 'Termos',
                    builder: (context, state) {
                      return TermosPage(key: state.pageKey);
                    },
                  ),
                ],
              ),
            ],
          ),
          
        ],
      ),

      // Rota de Login (fora da navegação principal)
      GoRoute(
        path: '/loginRegister',
        name: 'LoginRegister',
        builder: (context, state) {
          return LoginRegisterPage(key: state.pageKey);
        },
      )
    ],
  );
});