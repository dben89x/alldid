import ReactOnRails from 'react-on-rails';

import Search from '../components/Search';
import SearchContainer from '../components/SearchContainer';
import FeaturedBarber from '../components/FeaturedBarber';
import ClientSidebar from '../components/ClientSidebar';
import Barber from '../components/Barber';
import Barbers from '../components/Barbers';
import BarberContainer from '../components/BarberContainer';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
	SearchContainer,
	Search,
	FeaturedBarber,
	ClientSidebar,
	Barber,
	Barbers,
	BarberContainer,
});
