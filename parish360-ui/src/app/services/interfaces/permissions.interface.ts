export interface User {
  id: string;
  username: string;
  first_name: string;
  last_name: string;
  email: string;
  dial_code: string;
  contact: string;
  password: string;
  is_active: boolean;
  currency: string;
  timezone: string;
  locale: string;
  roles: Role[];
}

export interface Role {
  id: string;
  name: string;
  description: string;
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
  isDeleteTriggered?: boolean;
}
