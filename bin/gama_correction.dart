import 'dart:math';

import 'package:image/image.dart';

// Função para aplicar a correção de gama a um pixel
Color applyGamma(Pixel pixel) {
  // Valor de gama utilizado na correção
  double gamma = 0.3; // Este valor pode ser ajustado conforme necessário

  // Calcular o inverso do valor de gama para aplicar a correção
  double gammaCorrection = 1 / gamma;

  // Aplicar a correção de gama a cada canal de cor do pixel
  int r = (pow(pixel.r / 255, gammaCorrection) * 255).round();
  int g = (pow(pixel.g / 255, gammaCorrection) * 255).round();
  int b = (pow(pixel.b / 255, gammaCorrection) * 255).round();

  // Criar um novo pixel com as cores corrigidas
  final pixelCorrigido = pixel.clone();
  pixelCorrigido.setRgb(r, g, b);

  return pixelCorrigido;
}

void main() async {
  // Carregar a imagem do arquivo especificado
  final image = await decodeImageFile('../Fig0309-a.png');

  // Verificar se a imagem foi carregada corretamente
  if (image == null) {
    throw Exception('Imagem nula');
  }

  // Percorrer todos os pixels da imagem e aplicar a correção de gama
  for (final Pixel pixel in image) {
    // Aplicar a correção de gama ao pixel atual
    final gammaCorrectedPixel = applyGamma(pixel);

    // Atualizar o pixel na imagem com o valor corrigido
    image.setPixel(pixel.x, pixel.y, gammaCorrectedPixel);
  }

  // Salvar a imagem ajustada em um novo arquivo
  await encodePngFile('../output/Fig0309-a_gama.png', image);

  print('Gama aplicado e imagem salva com sucesso!');
}
