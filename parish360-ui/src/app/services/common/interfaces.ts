export interface Place {
  location: string;
  city: string;
  state: string;
  country: string;
}

export interface Currency {
  code: string;
  name: string;
  symbol: string;
}
export interface CountryDialCode {
  name: string;
  code: string; // ISO Alpha-2
  dialCode: string; // International calling code
  flag: string; // Emoji flag
}
