function fn(){

	var config = {
	    baseURL : 'https://apiv2-test.coordinadora.com/recogidas/cm-solicitud-recogidas-ms/solicitud-recogida'
	};

	karate.configure('connectTimeout',5000);
	karate.configure('readTimeout',5000);

	return config;
}