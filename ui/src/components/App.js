import React, { Component } from 'react'
import { Route, Switch } from 'react-router-dom'
import { ApolloClient, ApolloProvider, createNetworkInterface } from 'react-apollo'
import Layout from './Layout'
import Call from './screens/Call'
import Chat from './screens/Chat'
import Home from './screens/Home'
import Maps from './screens/Maps'
import News from './screens/News'
import Ship from './screens/Ship'
import Messages from './screens/Chat/Messages'
import Video from './screens/Call/Video'

const client = new ApolloClient({
  networkInterface: createNetworkInterface({
    uri: `http://${window.location.hostname}:5000/graphql`
  })
})

class App extends Component {
  render() {
    return (
      <ApolloProvider client={client}>
        <Layout>
          <Switch>
            <Route exact path="/" component={Home} />
            <Route path="/call/:contact" component={Video} />
            <Route path="/call" component={Call} />
            <Route path="/chat/:channelId" component={Messages} />
            <Route path="/chat" component={Chat} />
            <Route path="/maps" component={Maps} />
            <Route path="/ship" component={Ship} />
            <Route path="/news" component={News} />
          </Switch>
        </Layout>
      </ApolloProvider>
    )
  }
}

export default App
