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
import 'package:app_cas_natal/pages/Glossario/sign_page.dart'; 
import 'package:app_cas_natal/pages/Configuracoes/config_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/editar_perfil_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/estatisticas_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/senha_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/sobre_page.dart';
import 'package:app_cas_natal/pages/Configuracoes/termos_page.dart';
import 'package:app_cas_natal/pages/Cursos/detalhe_curso_page.dart';
import 'package:app_cas_natal/pages/Cursos/cursos_page.dart';
import 'package:app_cas_natal/pages/Historia/historia_page.dart';
import 'package:app_cas_natal/pages/landing_page.dart';
import 'package:app_cas_natal/src/appuser/appuser_provider.dart';
import 'package:app_cas_natal/src/course/course_model.dart';
import 'package:app_cas_natal/src/lesson/lesson_model.dart';
import 'package:app_cas_natal/src/lesson/lesson_provider.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/foundation.dart';
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
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,

    redirect: (BuildContext context, GoRouterState state) async {
      final storage = ref.read(secureStorageProvider);
      final token = await storage.read(key: 'token');
      final isLoggedIn = token != null && token.isNotEmpty;

      final isGoingToLanding = state.matchedLocation == '/';
      final isGoingToLogin = state.matchedLocation == '/loginRegister';

      if (!kIsWeb && isGoingToLanding) return isLoggedIn ? '/cursos' : '/loginRegister';

      if (!isLoggedIn && !isGoingToLanding && !isGoingToLogin) return '/loginRegister';
      
      if (isLoggedIn && isGoingToLogin) return '/cursos';
      
      return null;
    },

    routes: <RouteBase>[

      GoRoute(
        path: '/',
        name: 'Landing',
        pageBuilder: (context, state) => buildPageWithTransition(
          context: context,
          state: state,
          child: const LandingPage(),
        ),
      ),
      GoRoute(
        path: '/loginRegister',
        name: 'LoginRegister',
        pageBuilder: (context, state) => buildPageWithTransition(
          context: context,
          state: state,
          child: LoginRegisterPage(key: state.pageKey),
        ),
      ),
      GoRoute(
        path: '/historia',
        name: 'Historia',
        pageBuilder: (context, state) => buildPageWithTransitionSlide(
          context: context,
          state: state,
          child: HistoriaCASPage(key: state.pageKey),
        ),
      ),


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
                pageBuilder: (context, state) => buildPageWithTransition(
                  context: context,
                  state: state,
                  child: CursosPage(key: state.pageKey),
                ),
                routes: [
                  GoRoute(
                    path: 'detalheCurso/:courseId',
                    name: 'DetalheCurso',
                    pageBuilder: (context, state) {
                      final courseId = state.pathParameters['courseId']!;
                      return buildPageWithTransition(
                        context: context,
                        state: state,
                        child: DetalheCursoPage(
                          key: state.pageKey, 
                          courseId: courseId,
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'video/:lessonId',
                        name: 'LessonVideo',
                        pageBuilder: (context, state) {
                          final lessonId = state.pathParameters['lessonId']!;
                          return buildPageWithTransitionSlide(
                            context: context,
                            state: state,
                            child: Consumer(
                              builder: (context, ref, child) {
                                final lessonAsync = ref.watch(lessonDetailProvider(lessonId)); 
                                return lessonAsync.when(
                                  loading: () => const Scaffold(body: Center(child: CarregandoWidget())),
                                  error: (error, stack) => Scaffold(body: Center(child: Text('Erro ao carregar vídeo: $error'))),
                                  data: (lesson) => LessonVideoPage(lesson: lesson, key: state.pageKey),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'content/:lessonId',
                        name: 'LessonContent',
                        pageBuilder: (context, state) {
                          final lessonId = state.pathParameters['lessonId']!;
                          return buildPageWithTransitionSlide(
                            context: context,
                            state: state,
                            child: Consumer(
                              builder: (context, ref, child) {
                                final lessonAsync = ref.watch(lessonDetailProvider(lessonId)); 
                                return lessonAsync.when(
                                  loading: () => const Scaffold(body: Center(child: CarregandoWidget())),
                                  error: (error, stack) => Scaffold(body: Center(child: Text('Erro ao carregar conteúdo: $error'))),
                                  data: (lesson) => LessonContentPage(lesson: lesson, key: state.pageKey),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'quiz/:lessonId',
                        name: 'LessonQuiz',
                        pageBuilder: (context, state) {
                          final lessonId = state.pathParameters['lessonId']!;
                          return buildPageWithTransitionSlide(
                            context: context,
                            state: state,
                            child: Consumer(
                              builder: (context, ref, child) {
                                final lessonAsync = ref.watch(lessonDetailProvider(lessonId)); 
                                return lessonAsync.when(
                                  loading: () => const Scaffold(body: Center(child: CarregandoWidget())),
                                  error: (error, stack) => Scaffold(body: Center(child: Text('Erro ao carregar quiz: $error'))),
                                  data: (lesson) => LessonQuizPage(lesson: lesson, key: state.pageKey),
                                );
                              },
                            ),
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
                pageBuilder: (context, state) => buildPageWithTransition(
                  context: context,
                  state: state,
                  child: GlossarioPage(key: state.pageKey),
                ),
                routes: [ 
                  GoRoute(
                    path: 'sinal/:signId',
                    name: 'SinalDetalhe',
                    pageBuilder: (context, state) {
                      final signId = state.pathParameters['signId']!;
                      return buildPageWithTransition(
                        context: context,
                        state: state,
                        child: SignPage(key: state.pageKey, signId: signId),
                      );
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
                pageBuilder: (context, state) => buildPageWithTransition(
                  context: context,
                  state: state,
                  child: ConfiguracoesPage(key: state.pageKey),
                ),
                routes: [
                  GoRoute(
                    path: '/editarPerfil',
                    name: 'EditarPerfil',
                    pageBuilder: (context, state) => buildPageWithTransition(
                      context: context,
                      state: state,
                      child: EditarPerfilPage(key: state.pageKey),
                    ),
                  ),
                  GoRoute(
                    path: '/estatisticas',
                    name: 'Estatisticas',
                    pageBuilder: (context, state) => buildPageWithTransition(
                      context: context,
                      state: state,
                      child: EstatisticasPage(key: state.pageKey),
                    ),
                  ),
                  GoRoute(
                    path: '/admin',
                    name: 'Admin',
                    pageBuilder: (context, state) => buildPageWithTransition(
                      context: context,
                      state: state,
                      child: AdminPage(key: state.pageKey),
                    ),
                    routes: [
                      GoRoute(
                        path: 'gestaoUsers',
                        name: 'GestaoUsers',
                        pageBuilder: (context, state) => buildPageWithTransition(
                          context: context,
                          state: state,
                          child: GestaoUsersPage(key: state.pageKey),
                        ),
                        routes: [
                          GoRoute(
                            path: 'cadastroUser',
                            name: 'CadastroUser',
                            pageBuilder: (context, state) => buildPageWithTransition(
                              context: context,
                              state: state,
                              child: CadastrarUserPage(key: state.pageKey),
                            ),
                          ),
                          GoRoute(
                            path: 'alterarUser',
                            name: 'AlterarUser',
                            pageBuilder: (context, state) => buildPageWithTransition(
                              context: context,
                              state: state,
                              child: UserPage(key: state.pageKey),
                            ),
                          )
                        ]
                      ),
                      GoRoute(
                        path: 'gestaoCurso',
                        name: 'GestaoCurso',
                        pageBuilder: (context, state) => buildPageWithTransition(
                          context: context,
                          state: state,
                          child: GestaoCursoPage(key: state.pageKey),
                        ),
                        routes: [
                          GoRoute(
                            path: 'cadastroCurso',
                            name: 'CadastroCurso',
                            pageBuilder: (context, state) => buildPageWithTransition(
                              context: context,
                              state: state,
                              child: CadastroCursoPage(key: state.pageKey),
                            ),
                          ),
                          GoRoute(
                            path: 'alterarCurso',
                            name: 'AlterarCurso',
                            pageBuilder: (context, state) {
                              final curso = state.extra as CourseModel;
                              return buildPageWithTransition(
                                context: context,
                                state: state,
                                child: CursoPage(key: state.pageKey, curso: curso),
                              );
                            },
                          ),
                        ]
                      ),
                      GoRoute(
                        path: 'gestaoAula',
                        name: 'GestaoAula',
                        pageBuilder: (context, state) => buildPageWithTransition(
                          context: context,
                          state: state,
                          child: GestaoAulaPage(key: state.pageKey),
                        ),
                        routes: [
                          GoRoute(
                            path: 'cadastroAula',
                            name: 'CadastroAula',
                            pageBuilder: (context, state) => buildPageWithTransition(
                              context: context,
                              state: state,
                              child: CadastroAulaPage(key: state.pageKey),
                            ),
                          ),
                          GoRoute(
                            path: 'alterarAula',
                            name: 'AlterarAula',
                            pageBuilder: (context, state) {
                              final aula = state.extra as LessonModel;
                              return buildPageWithTransition(
                                context: context,
                                state: state,
                                child: AulaPage(key: state.pageKey, aula: aula),
                              );
                            },
                          ),
                        ]
                      ),
                      GoRoute(
                        path: 'gestaoGlossario',
                        name: 'GestaoGlossario',
                        pageBuilder: (context, state) => buildPageWithTransition(
                          context: context,
                          state: state,
                          child: GestaoGlossarioPage(key: state.pageKey),
                        ),
                        routes: [
                          GoRoute(
                            path: 'cadastroGlossario',
                            name: 'CadastroGlossario',
                            pageBuilder: (context, state) => buildPageWithTransition(
                              context: context,
                              state: state,
                              child: CadastroGlossarioPage(key: state.pageKey),
                            ),
                          ),
                          GoRoute(
                            path: 'alterarGlossario',
                            name: 'AlterarGlossario',
                            pageBuilder: (context, state) => buildPageWithTransition(
                              context: context,
                              state: state,
                              child: GlossarioPage(key: state.pageKey),
                            ),
                          ),
                        ]
                      ),
                      GoRoute(
                        path: '/estatisticaAdmin',
                        name: 'EstatisticasAdmin',
                        pageBuilder: (context, state) => buildPageWithTransition(
                          context: context,
                          state: state,
                          child: EstatisticasAdminPage(key: state.pageKey),
                        ),
                      )
                    ]
                  ),
                  GoRoute(
                    path: '/redefinirSenha',
                    name: 'RedefinirSenha',
                    pageBuilder: (context, state) => buildPageWithTransition(
                      context: context,
                      state: state,
                      child: RedefinirSenhaPage(key: state.pageKey),
                    ),
                  ),
                  GoRoute(
                    path: '/sobre',
                    name: 'Sobre',
                    pageBuilder: (context, state) => buildPageWithTransition(
                      context: context,
                      state: state,
                      child: SobrePage(key: state.pageKey),
                    ),
                  ),
                  GoRoute(
                    path: '/termos',
                    name: 'Termos',
                    pageBuilder: (context, state) => buildPageWithTransition(
                      context: context,
                      state: state,
                      child: TermosPage(key: state.pageKey),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
        ],
      ),
    ],
  );
});

CustomTransitionPage buildPageWithTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: SelectionArea(child: child), 
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}

CustomTransitionPage buildPageWithTransitionSlide<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: SelectionArea(child: child),
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(0.05, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeOut)),
          ),
          child: child,
        ),
      );
    },
  );
}