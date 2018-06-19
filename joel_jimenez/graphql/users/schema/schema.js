const graphql = require('graphql');
const axios = require('axios');
const data_url = "http://10.116.53.33:3004"

const {
	GraphQLObjectType,
	GraphQLInt,
	GraphQLString,
	GraphQLSchema,
	GraphQLList,
	GraphQLNonNull
} = graphql;

const CompanyType = new GraphQLObjectType({
	name: "Company",
	fields: () => ({
		id: {
			type: GraphQLString
		},
		name: {
			type: GraphQLString
		},
		description: {
			type: GraphQLString
		},
		users: {
			type: new GraphQLList(UserType),
			resolve(parentValue, args){
				return axios.get(`${data_url}/companies/${parentValue.id}/users`)
						.then(response => response.data);
			}
		}
	})
});

const UserType = new GraphQLObjectType({
	name: 'User',
	fields: () => ({
		id: {
			type: GraphQLString
		},
		name: {
			type: GraphQLString
		},
		age: {
			type: GraphQLInt
		},
		company: {
			type: CompanyType,
			resolve(parentValue, args) {
				return axios.get(`${data_url}/companies/${parentValue.companyId}`)
						.then(response => response.data);
			}
		}
	})
});

const RootQuery = new GraphQLObjectType({
	name: 'RootQueryType',
	fields: {
		user: {
			type: UserType,
			args: {
				id: {
					type: GraphQLString
				}
			},
			resolve(parentValue, args) {
				return axios.get(`${data_url}/users/${args.id}`)
						.then(response => response.data);
			}
		},
		company: {
			type: CompanyType,
			args: {
				id: {
					type: GraphQLString
				}
			},
			resolve(parentValue, args) {
				return axios.get(`${data_url}/companies/${args.id}`)
						.then(response => response.data);
			}
		}
	}
}); 

const mutation = new GraphQLObjectType({
	name: 'Mutation',
	fields: {
		addUser: {
			type: UserType,
			args: {
				name: {
					type: new GraphQLNonNull(GraphQLString)
				},
				age: {
					type: new GraphQLNonNull(GraphQLInt)
				},
				companyId: {
					type: GraphQLString
				}
			},
			resolve(parentValue, { name, age }){
				return axios.post(`${data_url}/users`, { name, age })
						.then(response => response.data);
			}
		},
		deleteUser: {
			type: UserType,
			args: {
				id: {
					type: new GraphQLNonNull(GraphQLString)
				}
			},
			resolve(parentValue, { id }){
				return axios.delete(`${data_url}/users/${id}`)
						.then(response => response.data);
			}
		},
		updateUser: {
			type: UserType,
			args: {
				id: {
					type: new GraphQLNonNull(GraphQLString)
				},
				name: {
					type: GraphQLString
				},
				age: {
					type: GraphQLInt
				},
				companyId: {
					type: GraphQLString
				}
			},
			resolve(parentValue, args){
				return axios.patch(`${data_url}/users/${args.id}`, args)
						.then(response => response.data);
			}
		}
	}
});

module.exports = new GraphQLSchema({
	query: RootQuery,
	mutation
});