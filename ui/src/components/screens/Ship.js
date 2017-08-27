import React, { Component } from 'react'
import store from '../../store'

class Ship extends Component {
  componentDidMount() {
    store.menu.title = 'Ship Information'
    store.menu.left = null
    store.menu.right = null
    store.showNav = true
    document.body.scrollTop = 0
  }

  render() {
    return (
      <div className="screen ship">
        <section className="meal">
          <h2>Captain's Welcome Dinner</h2>
          <h3>Appetizers</h3>
          <div className="dish">
            <header style={{ backgroundImage: 'url(/images/macarons.jpg)' }}>
              <h4>Tomato-Feta-Basil Macarons</h4>
            </header>
            <p>
              A twist on the traditionally sweet cookie with its mild crust and tangy center of feta, fresh tomatoes and
              basil
            </p>
          </div>
          <div className="dish">
            <header style={{ backgroundImage: 'url(/images/cevapcici.jpg)' }}>
              <h4>Cevapcici with Tzatziki Dip</h4>
            </header>
            <p>These small sausages were introduced to Europe during the Ottoman Empire.</p>
          </div>
          <h3>Main Courses</h3>
          <div className="dish">
            <header style={{ backgroundImage: 'url(/images/beef-beer.jpg)' }}>
              <h4>Carbonnade à la Flamande</h4>
            </header>
            <p>
              Winter is the perfect time to make hearty meals that raise everyone’s spirits. This Flemish carbonnade
              relies on the flavor of Belgian abbey-style beer.
            </p>
          </div>
          <div className="dish">
            <header style={{ backgroundImage: 'url(/images/schnitzel.jpg)' }}>
              <h4>Wiener Schnitzel with Parsley Butter Potatoes</h4>
            </header>
            <p>
              This classic recipe comes to us from Austrian Master Chef Toni Mörwald, proprietor of Vienna’s
              Michelin-starred restaurant, Mörwald Gourmet “Toni M.”
            </p>
          </div>
          <h3>Dessert</h3>
          <div className="dish">
            <header style={{ backgroundImage: 'url(/images/yule-log.jpg)' }}>
              <h4>Bûche de Noël</h4>
            </header>
            <p>
              This grand dessert is a descendant of the medieval subtlety—food disguised to look like something else.
              Here, chocolate cake masquerades as the traditional yule log for a long winter’s night.
            </p>
          </div>
        </section>
        <section className="port-of-call">
          <h2>Port of Call</h2>
          <header>
            <img src="/images/veliko.jpg" alt="" />
            <h3>Veliko Tarnovo & Arbanasi, Bulgaria</h3>
          </header>
          <article>
            <p>
              After breakfast, disembark at Russe for a full-day excursion to Bulgaria’s former capital, Veliko Tarnovo.
              There you will see Tsaravets Hill and the ruins of the royal castle. During free time, shop for local
              crafts along Samovodska Charshia. Continue your venture to Arbanasi for lunch in a local restaurant and a
              guided tour of the Nativity Church with its intricate floor-to-ceiling murals and icons. Return to your
              ship for dinner.
            </p>
          </article>
          <h4>Shore Excursions</h4>
          <ul>
            <li>Veliko Tarnovo & Arbanasi</li>
            <li>Russe Highlights</li>
          </ul>
        </section>
      </div>
    )
  }
}

export default Ship
