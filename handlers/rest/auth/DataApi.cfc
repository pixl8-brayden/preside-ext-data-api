/**
 * Handler for authenticating with token authentication
 *
 */
component extends="preside.system.handlers.rest.auth.Token" {

	property name="dataApiUserConfigurationService" inject="dataApiUserConfigurationService";
	property name="presideRestService" inject="presideRestService";

	private string function authenticate() {
		var userId = super.authenticate( argumentCollection=arguments );

		if ( Len( Trim( userId ) ) ) {
			var uri      = restRequest.getUri();
			var verb     = restRequest.getVerb();
			var api      = restRequest.getApi();
			var resource = restRequest.getResource();
			var args     = presideRestService.extractTokensFromUri( restRequest );

			switch( resource.handler ) {
				case "data.v1.WholeEntity":
				case "data.v1.SingleRecord":
					if ( !dataApiUserConfigurationService.hasEntityAccess( userId, api, args.entity ?: "", verb ) ) {
						restResponse.setStatusText( "Access denied. Contact your administrator to ensure that you have [#verb#] access to the [#args.entity#] entity." );
						return "";
					}
				break;

				case "data.v1.QueueDelete":
				case "data.v1.QueueGet":
					if ( !dataApiUserConfigurationService.hasQueueAccess( userId, api, args.entity ?: "" ) ) {
						restResponse.setStatusText( "Access denied. Contact your administrator to ensure that you have a Queue subscription." );
						return "";
					}
				break;
			}
		}

		return userId;
	}

	private string function configure() {
		args.api = rc.id ?: "";
		args.apiUsers = dataApiUserConfigurationService.listUsersWithApiAccess( args.api );

		return renderView( view="/admin/rest/auth/dataapi/configure", args=args );
	}

}