import 'dart:html';
import 'dart:math';

import 'SubnettingPractice.dart';

void main()
{
  int numOfSubnets = 0;
  List<int> subnetSizes;
  querySelector('#btnGenerateNewProblem').onClick.listen((MouseEvent event)
  {
    const int intMax            =   2147483648;
    int IPAddress               =   generateRandomNumber(1, intMax + 1);
    int IPAddressFirstByte      =   (IPAddress & 0xFF000000) >> 24;
    int IPAddressSecondByte     =   (IPAddress & 0x00FF0000) >> 16;
    int IPAddressThirdByte      =   (IPAddress & 0x0000FF00) >> 8;
    int IPAddressFourthByte     =   IPAddress & 0x000000FF;
    int subnetMask              =   generateRandomNumber(16, 29);
    String IPAddressStr         =   IPAddressFirstByte.toString() + '.' + IPAddressSecondByte.toString() + '.'
        + IPAddressThirdByte.toString() + '.' + IPAddressFourthByte.toString() + '/' + subnetMask.toString();
    numOfSubnets                =   generateRandomNumber(3, 6);
    querySelector('#IPAddress').setInnerHtml(IPAddressStr);
    querySelector('#numOfSubnets').setInnerHtml(numOfSubnets.toString());

    int subnetSeqNum                              =   1;
    StringBuffer allSubnetAddrInputFieldsHtml     =   new StringBuffer();
    subnetSizes                                   =   generateListOfSubnetSizes(pow(2, 32 - subnetMask), numOfSubnets);
    while (subnetSeqNum <= numOfSubnets)
    {
      allSubnetAddrInputFieldsHtml.write(
          '<label>size:&nbsp;${subnetSizes[subnetSeqNum - 1]}&nbsp;</label>' +
              '<input id="subnetAddrField${subnetSeqNum}"></input><br>');
      subnetSeqNum++;
    }
    querySelector('#Subnets').setInnerHtml(allSubnetAddrInputFieldsHtml.toString());
    querySelector('#btnCheckAnswers').style.setProperty("display", "block");
    (querySelector('#broadcastAddr') as TextInputElement).value   =   '';
    (querySelector('#networkAddr') as TextInputElement).value     =   '';
    (querySelector('#numOfIPAddrs') as TextInputElement).value    =   '';
    (querySelector('#broadcastAddr') as TextInputElement).style.setProperty('background-color', 'inherit');
    (querySelector('#networkAddr') as TextInputElement).style.setProperty('background-color', 'inherit');
    (querySelector('#numOfIPAddrs') as TextInputElement).style.setProperty('background-color', 'inherit');
  });

  querySelector('#btnCheckAnswers').onClick.listen((MouseEvent)
  {
    String IPAddress                              =   querySelector('#IPAddress').innerHtml;
    String userEnteredBroadcastAddr               =   (querySelector('#broadcastAddr') as TextInputElement).value;
    String userEnteredNetworkAddr                 =   (querySelector('#networkAddr') as TextInputElement).value;
    String userEnteredNumOfIPs                    =   (querySelector('#numOfIPAddrs') as TextInputElement).value;
    List<bool> userEnteredAnswersAreCorrect       =   checkAnswers(IPAddress, userEnteredBroadcastAddr, userEnteredNetworkAddr, userEnteredNumOfIPs);
    List<String> userEnteredSubnetAddresses       =   new List<String>(numOfSubnets);
    for (int subnetPos = 0; subnetPos < numOfSubnets; subnetPos++)
      userEnteredSubnetAddresses[subnetPos] = (querySelector('#subnetAddrField${subnetPos + 1}') as TextInputElement).value;
    List<bool> userEnteredSubnetAddrsAreCorrect   =   checkSubnetAddresses(userEnteredSubnetAddresses);

    if (userEnteredAnswersAreCorrect[2])
      (querySelector('#broadcastAddr') as TextInputElement).style.setProperty('background-color', 'lime');
    else
      (querySelector('#broadcastAddr') as TextInputElement).style.setProperty('background-color', 'red');

    if (userEnteredAnswersAreCorrect[1])
      (querySelector('#networkAddr') as TextInputElement).style.setProperty('background-color', 'lime');
    else
      (querySelector('#networkAddr') as TextInputElement).style.setProperty('background-color', 'red');

    if (userEnteredAnswersAreCorrect[0])
      (querySelector('#numOfIPAddrs') as TextInputElement).style.setProperty('background-color', 'lime');
    else
      (querySelector('#numOfIPAddrs') as TextInputElement).style.setProperty('background-color', 'red');

    for (int subnetPos = 0; subnetPos < numOfSubnets; subnetPos++)
    {
      if (userEnteredSubnetAddrsAreCorrect[subnetPos])
        querySelector('#subnetAddrField${subnetPos + 1}').style.setProperty('background-color', 'lime');
      else
        querySelector('#subnetAddrField${subnetPos + 1}').style.setProperty('background-color', 'red');
    }
  });
}