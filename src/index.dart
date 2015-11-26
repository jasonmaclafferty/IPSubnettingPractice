import 'dart:html';
import 'SubnettingPractice.dart';

void main()
{
  querySelector('#btnGenerateNewProblem').onClick.listen((MouseEvent event)
  {
    const int intMax = 2147483648;
    int IPAddress = generateRandomNumber(1, intMax + 1);
    int IPAddressFirstByte = (IPAddress & 0xFF000000) >> 24;
    int IPAddressSecondByte = (IPAddress & 0x00FF0000) >> 16;
    int IPAddressThirdByte = (IPAddress & 0x0000FF00) >> 8;
    int IPAddressFourthByte = IPAddress & 0x000000FF;
    int subnetMask = generateRandomNumber(16, 29);
    String IPAddressStr = IPAddressFirstByte.toString() + '.' +
        IPAddressSecondByte.toString() + '.'
        + IPAddressThirdByte.toString() + '.' + IPAddressFourthByte.toString()
        + '/' + subnetMask.toString();
    int numOfSubnets = generateRandomNumber(3, 6);
    querySelector('#IPAddress').setInnerHtml(IPAddressStr);
    querySelector('#numOfSubnets').setInnerHtml(numOfSubnets.toString());

    int subnetSeqNum = 1;
    StringBuffer allSubnetAddrInputFieldsHtml = new StringBuffer();
    while (subnetSeqNum <= numOfSubnets)
    {
      allSubnetAddrInputFieldsHtml.write(
          '<label>Subnet $subnetSeqNum&nbsp;</label>' +
              '<input id="subnetAddrField${subnetSeqNum}"></input><br>');
      subnetSeqNum++;
    }
    querySelector('#Subnets').setInnerHtml(
        allSubnetAddrInputFieldsHtml.toString());
    querySelector('#btnCheckAnswers').style.setProperty("display", "block");
  });

  querySelector('#btnCheckAnswers').onClick.listen((MouseEvent)
  {
    String IPAddress = querySelector('#IPAddress').innerHtml;
    String userEnteredBroadcastAddr = (querySelector(
        '#broadcastAddr') as TextInputElement).value;
    String userEnteredNetworkAddr = (querySelector(
        '#networkAddr') as TextInputElement).value;
    String userEnteredNumOfIPs = (querySelector(
        '#numOfIPAddrs') as TextInputElement).value;
    bool userEnteredAnswersAreCorrect = checkAnswers(
        IPAddress, userEnteredBroadcastAddr,
        userEnteredNetworkAddr, userEnteredNumOfIPs);
    window.alert('User input is correct: $userEnteredAnswersAreCorrect');
    /* clear input when answers are correct */
    if (userEnteredAnswersAreCorrect)
    {
      (querySelector('#broadcastAddr') as TextInputElement).value = '';
      (querySelector('#networkAddr') as TextInputElement).value = '';
      (querySelector('#numOfIPAddrs') as TextInputElement).value = '';
    }
  });
}