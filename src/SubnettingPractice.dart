library SubnettingPractice;

import 'dart:math';

// returns a random number in the range [lowerBound, upperBound) (from lowerBound inclusive to upperBound exclusive)
int generateRandomNumber(int lowerBound, int upperBound)
{
  Random randNumGenerator = new Random();
  int randomNumber = randNumGenerator.nextInt(upperBound);
  while (randomNumber < lowerBound)
    randomNumber = randNumGenerator.nextInt(upperBound);

  return randomNumber;
}

bool checkAnswers(String ipAddrStr, String userEnteredBroadcastAddr, String userEnteredNetworkAddr, String userEnteredNumOfIPs)
{
  bool answersAreCorrect = false;
  List<String> ipAddrAndMask = ipAddrStr.split('/');
  int ipAddress = convertDottedIPAddressStringToInteger(ipAddrAndMask[0]);
  int subnetMask = int.parse(ipAddrAndMask[1]);
  int correctNumOfIPs = pow(2, 32 - subnetMask);
  int networkAddrMask = (0xFFFFFFFF >> (32 - subnetMask)) << (32 - subnetMask);
  int correctNetworkAddr = ipAddress & networkAddrMask;
  int correctBroadcastAddr = ipAddress | (0xFFFFFFFF >> subnetMask);
  int userEnteredBroadcastAddrInt = convertDottedIPAddressStringToInteger(userEnteredBroadcastAddr);
  int userEnteredNetworkAddrInt = convertDottedIPAddressStringToInteger(userEnteredNetworkAddr);

  if (int.parse(userEnteredNumOfIPs) == correctNumOfIPs &&
      userEnteredBroadcastAddrInt == correctBroadcastAddr
      && userEnteredNetworkAddrInt == correctNetworkAddr)
    answersAreCorrect = true;

  return answersAreCorrect; // a boolean indicating whether or not the user-entered number of IPs, network Address
  // and broadcast address are correct
}

int convertDottedIPAddressStringToInteger(String dottedIPAddressString)
{
  List<String> ipAddressComponents = dottedIPAddressString.split('.');
  int ipAddrFirstByte = int.parse(ipAddressComponents[0]) << 24;
  int ipAddrSecondByte = int.parse(ipAddressComponents[1]) << 16;
  int ipAddrThirdByte = int.parse(ipAddressComponents[2]) << 8;
  int ipAddrFourthByte = int.parse(ipAddressComponents[3]);
  int ipAddress = ipAddrFourthByte + ipAddrThirdByte + ipAddrSecondByte + ipAddrFirstByte;

  return ipAddress;
}

List<int> generateListOfSubnetSizes(int numOfAllocatedIPAddresses, int numOfSubnets)
{
  List<int> subnetSizes     =   new List.filled(numOfSubnets, 0);
  bool done                 =   false;
  int subnetCtr             =   0;
  int randNum               =   0;
  while (!done)
  {
    if (subnetSizes.every((num) => num > 0))
      if (sumOfListElements(subnetSizes) <= numOfAllocatedIPAddresses)
        done = true;
      else if (subnetCtr > numOfSubnets - 1)
        subnetCtr = 0;
    if (subnetCtr < numOfSubnets)
    {
      randNum = generateRandomNumber(16, numOfAllocatedIPAddresses ~/ numOfSubnets);
      if (sumOfListElements(subnetSizes) > numOfAllocatedIPAddresses || !subnetSizes.every((num) => num > 0))
        subnetSizes[subnetCtr] = randNum + (16 - (randNum % 16));
      subnetCtr++;
    }
  }

  return subnetSizes;
}

int sumOfListElements(List<int> list)
{
  int sum = 0;
  for (int num in list)
    sum += num;

  return sum;
}

List<bool> checkSubnetAddresses(List<String> userEnteredSubnetAddresses)
{
  List<bool> subnetsAreCorrect = new List<bool>(userEnteredSubnetAddresses.length);

  return subnetsAreCorrect;
}
