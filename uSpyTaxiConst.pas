unit uSpyTaxiConst;

interface

uses uDataConstantStorage;

const
  constBingAPIKey: string = 'ArlyKldofYxmTMOXnHlmlQ-fbUJHSKAQlI6HRo_owmWYBYsPSwJ-6bwL2uI_P17B';
  constTaxiFileName = 'Taxi_1.png';

  constCenterMoscowTopLeftLatitude = 55.767664;
  constCenterMoscowTopLeftLongitude = 37.596977;

  constCenterMoscowRightLatitude = 55.744125;
  constCenterMoscowRightLongitude = 37.658476;

  constKremlinLatitude = 55.751045;
  constKremlinLongitude = 37.615702;
  constDBConnectionParams: TDBConnectionParams = (DatabaseName: '192.168.2.150:spytaxi'; UserName: 'SYSDBA'; Password: '101';
    Role: '');
implementation

end.
