const graphql = require('graphql');
const axios = require('axios');
const data_url = "http://localhost:3004"

const {
	GraphQLObjectType,
	GraphQLString,
	GraphQLSchema,
	GraphQLList,
	GraphQLNonNull,
	GraphQLBoolean
} = graphql;

const ListType = new GraphQLObjectType({
	name: "List",
	fields: () => ({
		id: {
			type: GraphQLString
		},
		name: {
			type: GraphQLString
		},
		tasks: {
			type: new GraphQLList(TaskType),
			resolve(parentValue, args){
				return axios.get(`${data_url}/lists/${parentValue.id}/tasks`)
						.then(response => response.data);
			}
		}
	}) 
});

const TaskType = new GraphQLObjectType({
	name: 'Task',
	fields: () => ({
		id: {
			type: GraphQLString
		},
		name: {
			type: GraphQLString
		},
		completed: {
			type: GraphQLBoolean
		},
		list: {
			type: ListType,
			resolve(parentValue, args) {
				return axios.get(`${data_url}/lists/${parentValue.listId}`)
						.then(response => response.data);
			}
		}
	})
});

const RootQuery = new GraphQLObjectType({
	name: 'RootQueryType',
	fields: {
		tasks: {
			type: new GraphQLList(TaskType),
			resolve(parentValue, args) {
				return axios.get(`${data_url}/tasks`)
						.then(response => response.data);
			}
		},
		task: {
			type: TaskType,
			args: {
				id: {
					type: GraphQLString
				}
			},
			resolve(parentValue, args) {
				return axios.get(`${data_url}/tasks/${args.id}`)
						.then(response => response.data);
			}
		},
		lists: {
			type: new GraphQLList(ListType),
			resolve(parentValue, args) {
				return axios.get(`${data_url}/lists`)
						.then(response => response.data);
			}
		},
		list: {
			type: ListType,
			args: {
				id: {
					type: GraphQLString
				}
			},
			resolve(parentValue, args) {
				return axios.get(`${data_url}/lists/${args.id}`)
						.then(response => response.data);
			}
		}
	}
}); 

const mutation = new GraphQLObjectType({
	name: 'Mutation',
	fields: {
		addTask: {
			type: TaskType,
			args: {
				name: {
					type: new GraphQLNonNull(GraphQLString)
				},
				listId: {
					type: GraphQLString
				}
			},
			resolve(parentValue, { name, age }){
				return axios.post(`${data_url}/tasks`, { name, age })
						.then(response => response.data);
			}
		},
		deleteTask: {
			type: TaskType,
			args: {
				id: {
					type: new GraphQLNonNull(GraphQLString)
				}
			},
			resolve(parentValue, { id }){
				return axios.delete(`${data_url}/tasks/${id}`)
						.then(response => response.data);
			}
		},
		updateTask: {
			type: TaskType,
			args: {
				id: {
					type: new GraphQLNonNull(GraphQLString)
				},
				name: {
					type: GraphQLString
				},
				listId: {
					type: GraphQLString
				}
			},
			resolve(parentValue, args){
				return axios.patch(`${data_url}/tasks/${args.id}`, args)
						.then(response => response.data);
			}
		}
	}
});

module.exports = new GraphQLSchema({
	query: RootQuery,
	mutation
});