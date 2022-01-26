part of '../../../home_view.dart';

enum TypeOffert { buy, sell }

class MyOffertsTab extends StatelessWidget {
  const MyOffertsTab({
    required this.viewModel,
    required this.textTheme,
    required this.listBanks,
    required this.hAppbar,
    required this.hBody,
  });

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final List<Bank> listBanks;
  final double hAppbar;
  final double hBody;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //Alturas de el APpbar y el body

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: LdAppbar(
        title: 'Mis ofertas',
        goLogin: (context) => viewModel.goLogin(context),
        // withBackIcon: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          color: LdColors.white,
          child: Column(
            children: <Widget>[
              Container(
                // width: size.width,
                color: LdColors.blackBackground,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: <Widget>[
                    // Esto es el circulo, ideal volverlo widget
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        // El tamaño depende del tamaño de la pantalla
                        width: (size.width) / 4,
                        height: (size.width) / 4,
                        child: QuarterCircle(
                          circleAlignment: CircleAlignment.bottomRight,
                          color: LdColors.grayLight.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        width: (size.width) * 2 / 4,
                        height: (size.width) * 2 / 4,
                        child: QuarterCircle(
                          circleAlignment: CircleAlignment.bottomRight,
                          color: LdColors.grayLight.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        width: (size.width) * 3 / 4,
                        height: (size.width) * 3 / 4,
                        child: QuarterCircle(
                          circleAlignment: CircleAlignment.bottomRight,
                          color: LdColors.grayLight.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: hAppbar),
                    ),
                    Column(
                      children: <TabBar>[
                        TabBar(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          indicatorColor: LdColors.orangePrimary,
                          indicatorWeight: 3,
                          labelColor: Colors.grey,
                          onTap: (int tab) {
                            if (tab == 0) {
                              viewModel.swapType(TypeOffert.buy);
                            }
                            if (tab == 1) {
                              viewModel.swapType(TypeOffert.sell);
                            }
                          },
                          tabs: <Widget>[
                            Tab(
                              child: Text(
                                'Para comprar',
                                style: textTheme.textYellow.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: LdColors.orangePrimary),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Para vender',
                                style: textTheme.textYellow.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: LdColors.orangePrimary),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ListCreateOffertSwitch(
                        type: TypeOffert.buy,
                        textTheme: textTheme,
                        size: size,
                        viewModel: viewModel,),
                    ListCreateOffertSwitch(
                        type: TypeOffert.sell,
                        textTheme: textTheme,
                        size: size,
                        viewModel: viewModel,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListCreateOffertSwitch extends StatelessWidget {
  const ListCreateOffertSwitch({
    Key? key,
    required this.type,
    required this.textTheme,
    required this.size,
    required this.viewModel,
  }) : super(key: key);

  final TypeOffert type;
  final TextTheme textTheme;
  final Size size;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: false
          ? ListMyOffersSale('data', textTheme: textTheme,viewModel: viewModel,)
          : NotOffersYet(
              viewModel: viewModel,
              textTheme: textTheme,
              size: size,
              type: type,
            ),
    );
  }
}

class NotOffersYet extends StatelessWidget {
  const NotOffersYet({
    Key? key,
    required this.viewModel,
    required this.textTheme,
    required this.size,
    required this.type,
  }) : super(key: key);

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final Size size;
  final TypeOffert type;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: SvgPicture.asset(
            viewModel.status.image,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Text(
                viewModel.status.titleText,
                style: textTheme.textBigBlack,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: size.width * .7,
                child: Text(
                    'Crea tu primera oferta y vuelve aqui para hacerle seguimineto',
                    textAlign: TextAlign.center,
                    style: textTheme.textSmallBlack),
              ),
            ],
          ),
        ),
        PrimaryButtonCustom(
          viewModel.status.buttonText,
          onPressed: () {
            userProvider.getUserLogged!=null
                ? viewModel.goCreateOffert(context, type)
                :  viewModel.goLogin(context);
          }
                              ,
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

// {
// "data": [
// {
// "user": {
// "nickName": "JDorado",
// "rateSeller": "5",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "6797fe47-388c-4331-8cdc-7128c59bdb20",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "1",
// "margin": "1",
// "termsOfTrade": "",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "1/25/2022 9:45:06 PM",
// "contract": "",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "f54a33ce-c970-4110-8efa-170ca5a9f125",
// "bankId": "1cdc9533-d2bd-421a-9d16-90d3b6667814",
// "advertisementId": "6797fe47-388c-4331-8cdc-7128c59bdb20",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// }
// ]
// }
// },
// {
// "user": {
// "nickName": "Vendedor1",
// "rateSeller": "0",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "e1467a75-1e04-401b-8491-ca5b55e4559d",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "2500000",
// "margin": "1",
// "termsOfTrade": "Oferta para crear el contrato inteligente",
// "idUserPublish": "d399d1c8-a165-466e-a98e-0a69c176f5a3",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "1/11/2022 10:29:28 AM",
// "contract": "AdressTemporal123",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "b731c924-adc9-478c-ada1-ddfe44786866",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "e1467a75-1e04-401b-8491-ca5b55e4559d",
// "accountNumber": "101010101",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "eb2e8229-13ee-4282-b053-32e7b444ea10",
// "documentNumber": "987654321",
// "titularUserName": "Carmen Martinez"
// },
// {
// "id": "e6125050-e321-4e98-b961-8362569063c1",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "e1467a75-1e04-401b-8491-ca5b55e4559d",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// }
// ]
// }
// },
// {
// "user": {
// "nickName": "JDorado",
// "rateSeller": "5",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "998db608-c39d-4ed0-87d8-4ea25fba5c34",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "20000000",
// "margin": "0.7",
// "termsOfTrade": "",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "1/5/2022 6:25:16 PM",
// "contract": "",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "1b0ee11e-32cf-4d23-ac8f-0d72aec9bcf7",
// "bankId": "97e40675-530e-4364-8431-1cf40ce1e021",
// "advertisementId": "998db608-c39d-4ed0-87d8-4ea25fba5c34",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// }
// ]
// }
// },
// {
// "user": {
// "nickName": "JDorado",
// "rateSeller": "5",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "53677bf7-43ba-433f-8083-5a083274ca5d",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "1200000",
// "margin": "1.3",
// "termsOfTrade": "",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "1/5/2022 6:21:02 PM",
// "contract": "",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "b448009a-3f4b-4c3a-883b-6e13e0c43af5",
// "bankId": "a86034f3-997f-493b-b3bb-c112a96a772e",
// "advertisementId": "53677bf7-43ba-433f-8083-5a083274ca5d",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// }
// ]
// }
// },
// {
// "user": {
// "nickName": "rdg2",
// "rateSeller": "5",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "ff9dd59e-3ed8-42c1-b692-e5dfdc41376a",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "5050000",
// "margin": "1",
// "termsOfTrade": "solo pagos en la noche",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "1/5/2022 6:10:39 PM",
// "contract": "",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "b9f2e994-0777-4d98-9b99-f3ec5cf13ec4",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "ff9dd59e-3ed8-42c1-b692-e5dfdc41376a",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// }
// ]
// }
// },
// {
// "user": {
// "nickName": "rdg2",
// "rateSeller": "5",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "d3185862-b356-48ed-940f-71ea2f286fcd",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "5000",
// "margin": "1",
// "termsOfTrade": "solo pagos en la noche",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "1/5/2022 5:10:20 PM",
// "contract": "",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "16c72622-94c4-475a-85c9-1000974d685e",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "d3185862-b356-48ed-940f-71ea2f286fcd",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// }
// ]
// }
// },
// {
// "user": {
// "nickName": "rdg2",
// "rateSeller": "5",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "13ab4933-1b28-4d48-a276-0e8f3454c671",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "5000",
// "margin": "1",
// "termsOfTrade": "solo pagos en la noche",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "1/5/2022 5:09:15 PM",
// "contract": "",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "c1954b1e-122c-4d1c-b25d-60fa41230d21",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "13ab4933-1b28-4d48-a276-0e8f3454c671",
// "accountNumber": "101010101",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "eb2e8229-13ee-4282-b053-32e7b444ea10",
// "documentNumber": "987654321",
// "titularUserName": "Carmen Martinez"
// },
// {
// "id": "cb49cef4-f8a9-4d45-8d9e-6929ccd05668",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "13ab4933-1b28-4d48-a276-0e8f3454c671",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// }
// ]
// }
// },
// {
// "user": {
// "nickName": "rdg2",
// "rateSeller": "5",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "d684f417-2760-4054-a87c-f2dfc2b16f83",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "5000",
// "margin": "1",
// "termsOfTrade": "solo pagos en la noche",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "1/5/2022 5:04:01 PM",
// "contract": "",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "8fd21943-0b3b-4899-b151-7d7a2f8e01cd",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "d684f417-2760-4054-a87c-f2dfc2b16f83",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// },
// {
// "id": "c04ce963-2b7d-4466-bc13-30e0332d99a2",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "d684f417-2760-4054-a87c-f2dfc2b16f83",
// "accountNumber": "101010101",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "eb2e8229-13ee-4282-b053-32e7b444ea10",
// "documentNumber": "987654321",
// "titularUserName": "Carmen Martinez"
// }
// ]
// }
// },
// {
// "user": {
// "nickName": "rdg2",
// "rateSeller": "5",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "ffb67bce-4603-456a-97de-dba3a53a5cf3",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "5000",
// "margin": "1",
// "termsOfTrade": "solo pagos en la noche",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "12/31/2021 4:10:12 PM",
// "contract": "",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "5388aed6-f870-4769-adfe-53e24e1f8740",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "ffb67bce-4603-456a-97de-dba3a53a5cf3",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// },
// {
// "id": "689d956c-aee2-4d96-a75c-4518ad65fd9c",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "ffb67bce-4603-456a-97de-dba3a53a5cf3",
// "accountNumber": "101010101",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "eb2e8229-13ee-4282-b053-32e7b444ea10",
// "documentNumber": "987654321",
// "titularUserName": "Carmen Martinez"
// }
// ]
// }
// },
// {
// "user": {
// "nickName": "rdg2",
// "rateSeller": "5",
// "rateBuyer": "0"
// },
// "advertisement": {
// "id": "80a413d6-54c8-4ae2-9c03-08bef666ebeb",
// "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "5000",
// "margin": "1",
// "termsOfTrade": "solo pagos en la noche",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "idStatus": "4a25d12a-7bc7-454a-82b6-ff64e7d5e60e",
// "expiredDate": "12/31/2021 9:52:38 AM",
// "contract": "",
// "secretBuyerKey": "",
// "secretSellerKey": "",
// "advertisementPayAccount": [
// {
// "id": "a1a5a470-ee3e-4129-acf2-966890062a8f",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "80a413d6-54c8-4ae2-9c03-08bef666ebeb",
// "accountNumber": "555555555",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentNumber": "123456789",
// "titularUserName": "Roger Gutierrez"
// },
// {
// "id": "f5a9193a-1412-41b2-8d5b-a68901cde8ad",
// "bankId": "249bfcd0-4ab0-49a8-a886-63ce42c919a6",
// "advertisementId": "80a413d6-54c8-4ae2-9c03-08bef666ebeb",
// "accountNumber": "101010101",
// "accountTypeId": "c047a07c-2daf-48a7-ad49-ec447a93485b",
// "documentTypeID": "eb2e8229-13ee-4282-b053-32e7b444ea10",
// "documentNumber": "987654321",
// "titularUserName": "Carmen Martinez"
// }
// ]
// }
// }
// ],
// "totalItems": 12,
// "totalPages": 2
// }
}

