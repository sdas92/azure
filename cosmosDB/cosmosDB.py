#**********Author: Somnath Das**************

import azure.cosmos.cosmos_client as cosmos_client

# Initialize the Cosmos client
client = cosmos_client.CosmosClient(url_connection='https://<you-cosmos-account>-cosmos-db.documents.azure.com', auth={'masterKey': 'your-primary-key'})
#Change the url_connection & masterKey value. You can get it from Azure Portal > Cosmos > Keys.

# Create a database
db = client.CreateDatabase({'id': 'som-gl-cosmos-db'}) #Change the id as per your requirement.
print(db)

# Create container options
options = {
    'offerThroughput': 400
}

container_definition = {
    'id': 'som-gl-cosmos-container' #Change the id as per your requirement.
}

# Create a container
container = client.CreateContainer(db['_self'], container_definition, options)


# Create and add some items to the container
item1 = client.CreateItem(container['_self'], {
    'id': 'somnath.das@hcl.com',
    'fname': 'Somnath',
    'lname': 'Das',
    'organization': 'HCL',
    'location': 'Mumbai'
    }
)

# Query these items in SQL
query = {'query': 'SELECT * FROM server s'}

options = {}
options['enableCrossPartitionQuery'] = True
options['maxItemCount'] = 2

result_iterable = client.QueryItems(container['_self'], query, options)
for item in iter(result_iterable):
    print(item)
