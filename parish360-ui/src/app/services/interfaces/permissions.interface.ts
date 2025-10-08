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
  data_owner: {
    [key: string]: string[];
  };
  modules: {
    [key: string]: string[];
  };
}
export interface FooterEvent {
  isEditMode: boolean;
  isSaveTriggered: boolean;
  isCancelTriggered: boolean;
}
