/**
 * @singleton      true
 * @presideService true
 */
component {

	public any function init() {
		return this;
	}

// PUBLIC API
	public void function logAction(
		  required string action
		, required string recordId
		, required string objectName
		,          string namespace = ""
	) {
		if ( !$isFeatureEnabled( "dataApiLog" ) ) {
			return;
		}

		var poService = $getPresideObjectService();
		if ( poService.objectExists( objectName=arguments.objectName ) ) {
			var query  = poService.selectData( id=arguments.recordId ,objectName=arguments.objectName );

			if ( query.recordcount ) {
				$getPresideObject( "data_api_log" ).insertData( data={
					  object_name    = arguments.objectName
					, namespace      = arguments.namespace
					, record_id      = arguments.recordId
					, operation      = arguments.action
					, serialize_data = serializeJSON( queryGetRow( query, 1 ) )
				} );
			}
		}
	}
}