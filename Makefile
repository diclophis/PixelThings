# Makefile for populating data, requires PARSE_APPLICATION_ID and PARSE_MASTER_KEY to be exported

bootstrap:
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"description": "category A", "integer_id": 0 }' https://api.parse.com/1/classes/ItemCategory
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"description": "category B", "integer_id": 1 }' https://api.parse.com/1/classes/ItemCategory
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"description": "category C", "integer_id": 2 }' https://api.parse.com/1/classes/ItemCategory
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"description": "category D", "integer_id": 3 }' https://api.parse.com/1/classes/ItemCategory
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"description": "category E", "integer_id": 4 }' https://api.parse.com/1/classes/ItemCategory
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 0, "itemCategoryId": 0, "name": "item A1", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 1, "itemCategoryId": 0, "name": "item A2", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 2, "itemCategoryId": 0, "name": "item A3", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 3, "itemCategoryId": 0, "name": "item A4", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 4, "itemCategoryId": 1, "name": "item B1", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 5, "itemCategoryId": 1, "name": "item B2", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 6, "itemCategoryId": 1, "name": "item B3", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 7, "itemCategoryId": 1, "name": "item B4", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 8, "itemCategoryId": 2, "name": "item C1", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 9, "itemCategoryId": 2, "name": "item C2", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 10, "itemCategoryId": 2, "name": "item C3", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 11, "itemCategoryId": 2, "name": "item C4", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 11, "itemCategoryId": 3, "name": "item D1", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 12, "itemCategoryId": 3, "name": "item D2", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 13, "itemCategoryId": 3, "name": "item D3", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
	curl --user $(PARSE_APPLICATION_ID):$(PARSE_MASTER_KEY) -X POST -H "Content-Type: application/json" -d '{"constrained": true, "costInPoints": 100, "filename": "foo", "frames": 1, "integer_id": 14, "itemCategoryId": 3, "name": "item D4", "quantityAvailable": 100, "variations": 1 }' https://api.parse.com/1/classes/FunItem
