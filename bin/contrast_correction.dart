import 'package:image/image.dart';

void main() async {
  // Carregar a imagem do arquivo especificado
  final image = await decodeImageFile('../Fig0241-a.png');

  // Verificar se a imagem foi carregada corretamente
  if (image == null) {
    throw Exception('Imagem nula');
  }

  // Inicializar valores de cinza mínimo e máximo para o ajuste de contraste
  // minGray é inicializado com um valor alto e maxGray com um valor baixo
  // Estes valores podem ser ajustados conforme a necessidade
  num minGray = 180;
  num maxGray = 75;

  // Percorrer todos os pixels da imagem para encontrar os valores
  // reais de cinza mínimo e máximo
  for (final Pixel pixel in image) {
    final grey = pixel.luminance;

    // Atualiza minGray se encontrar um valor de cinza mais baixo
    if (grey < minGray) minGray = grey;

    // Atualiza maxGray se encontrar um valor de cinza mais alto
    if (grey > maxGray) maxGray = grey;
  }

  // Ajustar o contraste de cada pixel na imagem
  for (final Pixel pixel in image) {
    final grey = pixel.luminance;

    // Calcula o novo valor de cinza com base no ajuste de contraste
    final adjustedGrey = ((grey - minGray) * 255 / (maxGray - minGray)).round().clamp(0, 255);

    // Atualiza o pixel na imagem com o novo valor de cinza
    image.setPixelRgb(pixel.x, pixel.y, adjustedGrey, adjustedGrey, adjustedGrey);
  }

  // Salva a imagem ajustada em um novo arquivo
  await encodePngFile('../output/Fig0241-a_contrast.png', image);

  print('Contraste aplicado e imagem salva com sucesso!');
}
