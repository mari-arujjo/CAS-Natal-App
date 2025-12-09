
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/course/course_model.dart';
import 'package:app_cas_natal/src/course/course_provider.dart';
import 'package:app_cas_natal/widgets/vizualizacao/carregando_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListaCursoWidget extends ConsumerStatefulWidget {
  final ValueChanged<String?>? onChanged;
  final String? initialCourseId;

  const ListaCursoWidget({
    super.key,
    this.onChanged,
    this.initialCourseId,
  });

  @override
  ConsumerState<ListaCursoWidget> createState() => _ListaCursoWidgetState();
}

class _ListaCursoWidgetState extends ConsumerState<ListaCursoWidget> {
  String? _selectedCourseId;

  @override
  void initState() {
    super.initState();
    _selectedCourseId = widget.initialCourseId;
  }

  @override
  Widget build(BuildContext context) {
    final cor = Cores();
    final coursesAsync = ref.watch(courseProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Color(0xFF494949), offset: Offset(0, 1))
        ]),
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonHideUnderline(
          child: coursesAsync.when(
            data: (courses) {
              if (_selectedCourseId != null &&
                  !courses.any((c) => c.id == _selectedCourseId)) {
                _selectedCourseId = null;
              }

              return DropdownButton<String>(
                value: _selectedCourseId,
                dropdownColor: Colors.white,
                isExpanded: true,
                borderRadius: BorderRadius.circular(14),
                hint: Text("Selecione o curso da aula.", style: TextStyle(color: cor.azulEscuro)),

                items: courses.map((CourseModel curso) {
                  return DropdownMenuItem<String>(
                    value: curso.id,
                    child: Text(curso.name,
                        style: TextStyle(color: cor.azulEscuro)),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    _selectedCourseId = value;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
              );
            },

            loading: () => const Center(child: CarregandoWidget()),
            error: (err, stack) => Text('Erro ao carregar cursos'),
          ),
        ),
      ),
    );
  }
}