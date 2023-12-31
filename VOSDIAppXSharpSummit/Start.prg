using System.Net
using System.Net.Security
using System.Security.Cryptography.X509Certificates

[STAThread];
FUNCTION Start() AS INT
    LOCAL oXApp AS XApp
    TRY
        oXApp := XApp{}
        oXApp:Start()
    CATCH oException AS Exception
        ErrorDialog(oException)
    END TRY
RETURN 0

CLASS XApp INHERIT App
METHOD Start() 
    LOCAL oMainWindow AS StandardSDIWindow

    ServicePointManager:Expect100Continue := true
    ServicePointManager:SecurityProtocol := SecurityProtocolType.Tls12
    //ServicePointManager.ServerCertificateValidationCallback = ServicePointManager_ServerCertificateValidationCallback;

    oMainWindow := StandardSDIWindow{SELF}
    oMainWindow:Show(SHOWCENTERED)

    SELF:Exec()
    
RETURN SELF    


END CLASS
