const BaseURL = "https://reqres.in/api";


const UserURL = '$BaseURL/users';


String AllUsersURL(int page)=> '$UserURL?page=$page';

String UserByIdURL(int id)=> '$UserURL/$id';
