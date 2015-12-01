library SubnettingPracticeTest;

import 'package:test/test.dart';

import '../src/SubnettingPractice.dart';

void main()
{
  group('checkAnswers()', ()
  {
    test('Test0',
        ()
    {
      expect(checkAnswers(
          '86.68.236.115/20', '86.68.239.255', '86.68.224.0', '4096'),
          equals(true));
    });
    test('Test1',
        ()
    {
      expect(checkAnswers(
          '100.96.43.23/21', '100.96.47.255', '100.96.40.0', '2048'),
          equals(true));
    });
    test('Test2',
        ()
    {
      expect(
          checkAnswers('128.64.0.255/28', '128.64.0.255', '128.64.0.240', '16'),
          equals(true));
    });
    test('Test3',
        ()
    {
      expect(
          checkAnswers('128.64.0.255/28', '128.64.255.255', '128.64.0.0', '16'),
          equals(false));
    });
    test('Test4',
        ()
    {
      expect(checkAnswers('128.64.0.255/28', '128.64.0.0', '128.64.0.255', '8'),
          equals(false));
    });
    test('Test5',
        ()
    {
      expect(checkAnswers(
          '74.156.74.67/16', '74.156.255.255', '74.156.0.0', '65536'),
          equals(true));
    });
    test('Test6',
        ()
    {
      expect(checkAnswers(
          '41.157.7.127/19', '41.157.31.255', '41.157.0.0', '8192'),
          equals(true));
    });
  });

  group('convertDottedIPAddressStringToInteger()', ()
  {
    test('Test0',
        ()
    {
      expect(convertDottedIPAddressStringToInteger('41.157.31.255'),
          equals(698163199));
    });
  });

  group('generateListOfSubnetSizes()', ()
  {
    test('Test0',
        ()
    {
      expect(sumOfListElements(generateListOfSubnetSizes(4096, 3)),
          lessThanOrEqualTo(4096));
    });

    test('Test1',
        ()
    {
      expect(sumOfListElements(generateListOfSubnetSizes(8192, 5)),
          lessThanOrEqualTo(8192));
    });

    test('Test2',
        ()
    {
      expect(sumOfListElements(generateListOfSubnetSizes(512, 6)),
          lessThanOrEqualTo(512));
    });

    test('Test3', () { expect( sumOfListElements( generateListOfSubnetSizes(65536, 3) ), lessThanOrEqualTo(65536) ); });

    test('Test4', () { expect( generateListOfSubnetSizes(65536, 3), everyElement((num) => num % 16 == 0) ); });

    test('Test5', () { expect( generateListOfSubnetSizes(8192, 5), everyElement((num) => num % 16 == 0) ); });

    test('Test6', () { expect( generateListOfSubnetSizes(512, 2), everyElement((num) => num % 16 == 0) ); });

    test('Test7', () { expect( generateListOfSubnetSizes(4096, 4), everyElement((num) => num % 16 == 0) ); });
  });
  group('checkSubnetAddresses()', ()
  {
    test('Test0', () { expect( checkSubnetAddresses(['128.64.0.0/23', '128.64.2.0/26', '128.64.3.0/28']), equals([true, true, true]) ); });

    test('Test1', () { expect( checkSubnetAddresses(['128.64.0.0/23', '128.64.1.0/26', '128.64.3.0/28']), equals([false, true, true]) ); });

    test('Test2', () { expect( checkSubnetAddresses(['0.0.0.0/23', '128.64.1.0/26', '128.64.3.0/28']), equals([true, true, true]) ); });

    test('Test3', () { expect( checkSubnetAddresses(['128.64.0.0/23', '128.64.2.0/26', '128.64.3.0/28', '128.64.2.64/26, 128.64.3.128/28']),
         equals([true, true, true, true]) ); });

    test('Test4', () { expect( checkSubnetAddresses(['192.64.16.8/18', '192.65.16.8/22']), equals([true, true]) ); });

    test('Test5', () { expect( checkSubnetAddresses(['192.65.16.8/18', '192.65.16.8/22']), equals([false, true]) ); });
  });
}