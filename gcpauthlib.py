class GcpAuthConnect : 
    def __init__(self,key_file_path) :
        from google.oauth2 import service_account
        self.auth = service_account.Credentials.from_service_account_file(key_file_path)
    
    def GetGcpAuth(self) :
        rAuth = self.auth
        return rAuth
