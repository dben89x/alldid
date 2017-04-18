import ReactOnRails from 'react-on-rails';

import Search from '../components/barbers/Search';
import SearchContainer from '../components/barbers/SearchContainer';
import FeaturedBarber from '../components/barbers/FeaturedBarber';
import ClientSidebar from '../components/barbers/ClientSidebar';
import Barber from '../components/barbers/Barber';
import Barbers from '../components/barbers/Barbers';
import BarberContainer from '../components/barbers/BarberContainer';
import UserStyles from '../components/forms/UserStyles';
import StyleTag from '../components/forms/StyleTag';
import UserServices from '../components/forms/UserServices';
import ServiceTag from '../components/forms/ServiceTag';

ReactOnRails.register({
	SearchContainer,
	Search,
	FeaturedBarber,
	ClientSidebar,
	Barber,
	Barbers,
	BarberContainer,
	UserStyles,
	StyleTag,
	UserServices,
	ServiceTag,
});
