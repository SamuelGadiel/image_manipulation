import 'package:image/image.dart';

void main() async {
  final image = await decodeImageFile('../Fig0115-a.png');

  if (image == null) {
    throw Exception('Imagem nula');
  }

  int bitsPerChannel = image.bitsPerChannel;

  for (int bitIndex = 0; bitIndex < bitsPerChannel; bitIndex++) {
    Image bitSliced = Image.from(image);

    for (final Pixel pixel in image) {
      int gray = pixel.luminance.toInt();

      // Divide o valor de cinza pelas potências de 2 para acessar cada bit
      for (int i = 0; i < bitsPerChannel - 1 - bitIndex; i++) {
        gray = gray ~/ 2; // Divisão inteira por 2
      }

      // Verifica se o bit menos significativo é 1 ou 0
      int bitValue = (gray % 2) != 0 ? 255 : 0;

      bitSliced.setPixelRgb(pixel.x, pixel.y, bitValue, bitValue, bitValue);
    }

    // Salva a imagem resultante
    String outputPath = '../output/Fig0115-a_bit${bitIndex + 1}.png';
    await encodePngFile(outputPath, bitSliced);
  }

  print('Fatiamento de bit aplicado e imagens salvas com sucesso!');
}
