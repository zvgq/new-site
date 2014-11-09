define ["ember-data"],
	(DS)->		
		serializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
			attrs:
				quotes: { embedded: 'always' }
			
		return serializer