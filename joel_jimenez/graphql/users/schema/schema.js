const graphql = require('graphql');
const axios = require('axios');
const data_url = "http://10.116.53.33:3004"

const {
	GraphQLObjectType,
	GraphQLInt,
	GraphQLString,
	GraphQLSchema,
	GraphQLList
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

module.exports = new GraphQLSchema({
	query: RootQuery
});