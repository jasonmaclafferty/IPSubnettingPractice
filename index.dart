import 'dart:html';
import 'dart:math';

void main()
{
  querySelector('#btnGenerateNewProblem').onClick.listen((MouseEvent event)
  {
    const int intMax          =   2147483648;
    int IPAddress             =   generateNonZeroRandomNumber(intMax);
    int IPAddressFirstByte    =   (IPAddress & 0xFF000000) >> 24;
    int IPAddressSecondByte   =   (IPAddress & 0x00FF0000) >> 16;
    int IPAddressThirdByte    =   (IPAddress & 0x0000FF00) >> 8;
    int IPAddressFourthByte   =   IPAddress & 0x000000FF;
    String IPAddressStr       =   IPAddressFirstByte.toString() + '.' + IPAddressSecondByte.toString() + '.'
                                  + IPAddressThirdByte.toString() + '.' + IPAddressFourthByte.toString();
    int numOfSubnets          =   generateNonZeroRandomNumber(10);
    querySelector('#IPAddress').setInnerHtml(IPAddressStr);
    querySelector('#numOfSubnets').setInnerHtml(numOfSubnets.toString());

    int subnetSeqNum                            =   1;
    String subnetAddrInputFieldHtml             =   '<label>Jason</label><input id="subnetAddrField${subnetSeqNum}">' +
                                                    '</input><br>';
    StringBuffer allSubnetAddrInputFieldsHtml   =   new StringBuffer();
    while (subnetSeqNum <= numOfSubnets)
    {
      allSubnetAddrInputFieldsHtml.write(subnetAddrInputFieldHtml);
      subnetSeqNum++;
    }
    querySelector('#Subnets').setInnerHtml(allSubnetAddrInputFieldsHtml.toString());
    querySelector('#btnCheckAnswers').style.setProperty("display", "block");
  });
}

int generateNonZeroRandomNumber(int upperBound)
{
  Random randNumGenerator   =   new Random();
  int randomNumber          =   randNumGenerator.nextInt(upperBound);
  while (randomNumber == 0)
    randomNumber = randNumGenerator.nextInt(upperBound);

  return randomNumber;
}