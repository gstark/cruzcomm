import React, { Component } from 'react'
import store from '../../../store'
import { gql, graphql } from 'react-apollo'
import { observer } from 'mobx-react'

const Contact = ({ name, onSelect }) =>
  <div className="contact item" onClick={() => onSelect(name)}>
    <img src={`https://api.adorable.io/avatars/32/${name}`} alt="" />
    <span>
      {name}
    </span>
  </div>

const List = ({ names, onSelect }) =>
  <div className="list">
    {names.map(n => <Contact name={n} key={n} onSelect={onSelect} />)}
  </div>

class Call extends Component {
  componentDidMount() {
    store.menu.title = `Welcome, ${store.username}`
    store.menu.left = null
    store.menu.right = null
    store.showNav = true
    document.body.scrollTop = 0
  }

  _select = name => {
    this.props.history.push('/call/' + name.toLowerCase().replace(/[^a-z0-9]/, ''))
  }

  render() {
    const { loading, allMessages } = this.props.data
    const members = loading
      ? []
      : allMessages.nodes.map(n => n.username).filter((n, i, s) => n !== store.username && s.indexOf(n) === i).sort()
    return (
      <div className="screen call">
        <List names={members} onSelect={this._select} />
      </div>
    )
  }
}

export default observer(
  graphql(gql`
    query {
      allMessages {
        nodes {
          id
          username
        }
      }
    }
  `)(Call)
)
