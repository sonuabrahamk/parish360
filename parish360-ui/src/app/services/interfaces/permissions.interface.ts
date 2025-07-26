export interface User {
  id: string;
  first_name: string;
  last_name: string;
  email: string;
  contact: string;
  status: string;
  roles: string[];
}

export interface Permissions {
  data: {
    [key: string]: string[];
  };
  screen: {
    [key: string]: string[];
  };
}
export interface FooterEvent {
  isEditMode: boolean;
  isSaveTriggered: boolean;
  isCancelTriggered: boolean;
}
