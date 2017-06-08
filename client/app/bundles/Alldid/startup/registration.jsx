import ReactOnRails from 'react-on-rails';

import Search from '../components/barbers/Search';
import SearchContainer from '../components/barbers/SearchContainer';
import FeaturedBarber from '../components/barbers/FeaturedBarber';
import ClientSidebar from '../components/barbers/ClientSidebar';
import Barber from '../components/barbers/Barber';
import BarberLink from '../components/barbers/BarberLink';
import Barbers from '../components/barbers/Barbers';
import BarberContainer from '../components/barbers/BarberContainer';
import BarberShowAttributes from '../components/barbers/BarberShowAttributes';

import ClientStyle from '../components/forms/ClientStyle';
import BarberStyle from '../components/forms/BarberStyle';
import UserStyles from '../components/forms/UserStyles';
import StyleTag from '../components/forms/StyleTag';
import UserServices from '../components/forms/UserServices';
import ServiceTag from '../components/forms/ServiceTag';
import HairProperties from '../components/forms/HairProperties';
import HairProperty from '../components/forms/HairProperty';
import OrganizationInput from '../components/forms/OrganizationInput';

import Calendar from '../components/calendar/Calendar';
import DailyEvents from '../components/calendar/DailyEvents';
import AppointmentModal from '../components/calendar/AppointmentModal';

import Schedule from '../components/schedule/Schedule';
import GeneralDay from '../components/schedule/GeneralDay';

ReactOnRails.register({
	SearchContainer,
	Search,
	FeaturedBarber,
	ClientSidebar,
	Barber,
	BarberLink,
	Barbers,
	BarberContainer,
	BarberShowAttributes,

	ClientStyle,
	StyleTag,
	UserServices,
	ServiceTag,
	UserStyles,
	BarberStyle,
	HairProperty,
	HairProperties,
	OrganizationInput,

	Calendar,
	DailyEvents,
	AppointmentModal,

	Schedule,
	GeneralDay,
});
