import 'package:flutter/material.dart';

class GenericErrorPage extends StatelessWidget {
  final String? errorMessage;
  final void Function()? onTap;
  const GenericErrorPage({
    super.key,
    this.onTap,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Text(
          errorMessage ??
              'Não foi possível carregar os dados, por favor clique na tela para tentar novamente',
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
