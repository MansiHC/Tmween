class NumberToWord {
  String convert(String locale, int digit) {
    final int number = digit;
    String numberString = '0000000000' + number.toString();
    numberString =
        numberString.substring(number.toString().length, numberString.length);
    var str = '';

    switch (locale) {
      case 'en':
        List<String> ones = [
          '',
          'One ',
          'Two ',
          'Three ',
          'Four ',
          'Five ',
          'Six ',
          'Seven ',
          'Eight ',
          'Nine ',
          'Ten ',
          'Eleven ',
          'Twelve ',
          'Thirteen ',
          'Fourteen ',
          'Fifteen ',
          'Sixteen ',
          'Seventeen ',
          'Eighteen ',
          'Nineteen '
        ];
        List<String> tens = [
          '',
          '',
          'Twenty',
          'Thirty',
          'Forty',
          'Fifty',
          'Sixty',
          'Seventy',
          'Eighty',
          'Ninety'
        ];

        str += (numberString[0]) != '0'
            ? ones[int.parse(numberString[0])] + 'Hundred '
            : ''; //hundreds
        if ((int.parse('${numberString[1]}${numberString[2]}')) < 20 &&
            (int.parse('${numberString[1]}${numberString[2]}')) > 9) {
          str += ones[int.parse('${numberString[1]}${numberString[2]}')] +
              'Crore ';
        } else {
          str += (numberString[1]) != '0'
              ? tens[int.parse(numberString[1])] + ' '
              : ''; //tens
          str += (numberString[2]) != '0'
              ? ones[int.parse(numberString[2])] + 'Crore '
              : ''; //ones
          str += (numberString[1] != '0') && (numberString[2] == '0')
              ? 'Crore '
              : '';
        }
        if ((int.parse('${numberString[3]}${numberString[4]}')) < 20 &&
            (int.parse('${numberString[3]}${numberString[4]}')) > 9) {
          str +=
              ones[int.parse('${numberString[3]}${numberString[4]}')] + 'Lakh ';
        } else {
          str += (numberString[3]) != '0'
              ? tens[int.parse(numberString[3])] + ' '
              : ''; //tens
          str += (numberString[4]) != '0'
              ? ones[int.parse(numberString[4])] + 'Lakh '
              : ''; //ones
          str += (numberString[3] != '0') && (numberString[4] == '0')
              ? 'Lakh '
              : '';
        }
        if ((int.parse('${numberString[5]}${numberString[6]}')) < 20 &&
            (int.parse('${numberString[5]}${numberString[6]}')) > 9) {
          str += ones[int.parse('${numberString[5]}${numberString[6]}')] +
              'Thousand ';
        } else {
          str += (numberString[5]) != '0'
              ? tens[int.parse(numberString[5])] + ' '
              : ''; //ten thousands
          str += (numberString[6]) != '0'
              ? ones[int.parse(numberString[6])] + 'Thousand '
              : ''; //thousands
          str += (numberString[5] != '0') && (numberString[6] == '0')
              ? 'Thousand '
              : '';
        }
        str += (numberString[7]) != '0'
            ? ones[int.parse(numberString[7])] + 'Hundred '
            : ''; //hundreds
        if ((int.parse('${numberString[8]}${numberString[9]}')) < 20 &&
            (int.parse('${numberString[8]}${numberString[9]}')) > 9) {
          str += ones[int.parse('${numberString[8]}${numberString[9]}')];
        } else {
          str += (numberString[8]) != '0'
              ? tens[int.parse(numberString[8])] + ' '
              : ''; //tens
          str += (numberString[9]) != '0'
              ? ones[int.parse(numberString[9])]
              : ''; //ones
        }
        break;
        case 'ar':
        List<String> ones = [
          '',
          'واحد ',
          'اثنين ',
          'ثلاثة ',
          'أربعة ',
          'خمسة ',
          'ستة ',
          'سبعة ',
          'ثمانية ',
          'تسع ',
          'عشرة ',
          'أحد عشر ',
          'اثني عشر ',
          'ثلاثة عشر ',
          'أربعة عشرة ',
          'خمسة عشر ',
          'السادس عشر ',
          'سبعة عشر ',
          'الثامنة عشر ',
          'تسعة عشر '
        ];
        List<String> tens = [
          '',
          '',
          'عشرين',
          'ثلاثين',
          'أربعين',
          'خمسون',
          'ستين',
          'سبعون',
          'ثمانون',
          'تسعين'
        ];

        str += (numberString[0]) != '0'
            ? ones[int.parse(numberString[0])] + 'مائة '
            : ''; //hundreds
        if ((int.parse('${numberString[1]}${numberString[2]}')) < 20 &&
            (int.parse('${numberString[1]}${numberString[2]}')) > 9) {
          str += ones[int.parse('${numberString[1]}${numberString[2]}')] +
              'الكرور عشرة ملا يين ';
        } else {
          str += (numberString[1]) != '0'
              ? tens[int.parse(numberString[1])] + ' '
              : ''; //tens
          str += (numberString[2]) != '0'
              ? ones[int.parse(numberString[2])] + 'الكرور عشرة ملا يين '
              : ''; //ones
          str += (numberString[1] != '0') && (numberString[2] == '0')
              ? 'الكرور عشرة ملا يين '
              : '';
        }
        if ((int.parse('${numberString[3]}${numberString[4]}')) < 20 &&
            (int.parse('${numberString[3]}${numberString[4]}')) > 9) {
          str +=
              ones[int.parse('${numberString[3]}${numberString[4]}')] + 'لكح ';
        } else {
          str += (numberString[3]) != '0'
              ? tens[int.parse(numberString[3])] + ' '
              : ''; //tens
          str += (numberString[4]) != '0'
              ? ones[int.parse(numberString[4])] + 'لكح '
              : ''; //ones
          str += (numberString[3] != '0') && (numberString[4] == '0')
              ? 'لكح '
              : '';
        }
        if ((int.parse('${numberString[5]}${numberString[6]}')) < 20 &&
            (int.parse('${numberString[5]}${numberString[6]}')) > 9) {
          str += ones[int.parse('${numberString[5]}${numberString[6]}')] +
              'ألف ';
        } else {
          str += (numberString[5]) != '0'
              ? tens[int.parse(numberString[5])] + ' '
              : ''; //ten thousands
          str += (numberString[6]) != '0'
              ? ones[int.parse(numberString[6])] + 'ألف '
              : ''; //thousands
          str += (numberString[5] != '0') && (numberString[6] == '0')
              ? 'ألف '
              : '';
        }
        str += (numberString[7]) != '0'
            ? ones[int.parse(numberString[7])] + 'مائة '
            : ''; //hundreds
        if ((int.parse('${numberString[8]}${numberString[9]}')) < 20 &&
            (int.parse('${numberString[8]}${numberString[9]}')) > 9) {
          str += ones[int.parse('${numberString[8]}${numberString[9]}')];
        } else {
          str += (numberString[8]) != '0'
              ? tens[int.parse(numberString[8])] + ' '
              : ''; //tens
          str += (numberString[9]) != '0'
              ? ones[int.parse(numberString[9])]
              : ''; //ones
        }
        break;

      case 'es':
        List<String> ones = [
          '',
          'Uno ',
          'Dos ',
          'Tres ',
          'Cuatro ',
          'Cinco ',
          'Seis ',
          'Siete ',
          'Ocho ',
          'Nueve ',
          'Diez ',
          'Once ',
          'Doce ',
          'Trece ',
          'Catorce ',
          'Quince ',
          'Dieciséis ',
          'De Diecisiete ',
          'Dieciocho ',
          'Diecinueve '
        ];
        List<String> tens = [
          '',
          '',
          'Veinte',
          'Treinta',
          'Cuarenta',
          'Cincuenta',
          'Sesenta',
          'Setenta',
          'Ochenta',
          'Noventa'
        ];

        str += (numberString[0]) != '0'
            ? ones[int.parse(numberString[0])] + 'Ciento '
            : ''; //hundreds
        if ((int.parse('${numberString[1]}${numberString[2]}')) < 20 &&
            (int.parse('${numberString[1]}${numberString[2]}')) > 9) {
          str += ones[int.parse('${numberString[1]}${numberString[2]}')] +
              'Millones De Rupias ';
        } else {
          str += (numberString[1]) != '0'
              ? tens[int.parse(numberString[1])] + ' '
              : ''; //tens
          str += (numberString[2]) != '0'
              ? ones[int.parse(numberString[2])] + 'Millones De Rupias '
              : ''; //ones
          str += (numberString[1] != '0') && (numberString[2] == '0')
              ? 'Millones De Rupias '
              : '';
        }
        if ((int.parse('${numberString[3]}${numberString[4]}')) < 20 &&
            (int.parse('${numberString[3]}${numberString[4]}')) > 9) {
          str +=
              ones[int.parse('${numberString[3]}${numberString[4]}')] + 'Lakh ';
        } else {
          str += (numberString[3]) != '0'
              ? tens[int.parse(numberString[3])] + ' '
              : ''; //tens
          str += (numberString[4]) != '0'
              ? ones[int.parse(numberString[4])] + 'Lakh '
              : ''; //ones
          str += (numberString[3] != '0') && (numberString[4] == '0')
              ? 'Lakh '
              : '';
        }
        if ((int.parse('${numberString[5]}${numberString[6]}')) < 20 &&
            (int.parse('${numberString[5]}${numberString[6]}')) > 9) {
          str += ones[int.parse('${numberString[5]}${numberString[6]}')] +
              'Mil ';
        } else {
          str += (numberString[5]) != '0'
              ? tens[int.parse(numberString[5])] + ' '
              : ''; //ten thousands
          str += (numberString[6]) != '0'
              ? ones[int.parse(numberString[6])] + 'Mil '
              : ''; //thousands
          str += (numberString[5] != '0') && (numberString[6] == '0')
              ? 'Mil '
              : '';
        }
        str += (numberString[7]) != '0'
            ? ones[int.parse(numberString[7])] + 'Ciento '
            : ''; //hundreds
        if ((int.parse('${numberString[8]}${numberString[9]}')) < 20 &&
            (int.parse('${numberString[8]}${numberString[9]}')) > 9) {
          str += ones[int.parse('${numberString[8]}${numberString[9]}')];
        } else {
          str += (numberString[8]) != '0'
              ? tens[int.parse(numberString[8])] + ' '
              : ''; //tens
          str += (numberString[9]) != '0'
              ? ones[int.parse(numberString[9])]
              : ''; //ones
        }
        break;

      default:
        str += 'not acceptable format';
    }

    return str;
  }
}
