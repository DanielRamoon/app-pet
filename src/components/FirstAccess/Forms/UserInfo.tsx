import MaskedInput from "@components/Wrappers/MaskedInput";
import WrappedSelect from "@components/Wrappers/Select";
import useColors from "@hooks/useColors";
import useUser from "@hooks/useUser";
import { Text } from "@ui-kitten/components";
import i18n from "@utils/i18n";
import { DateTime } from "luxon";
import { Select } from "native-base";
import React, { useCallback, useEffect, useState } from "react";
import { Alert, DeviceEventEmitter, View } from "react-native";
import { IUserInfo } from "src/@types/User";
import { styles } from "./styles";
import Input from "@components/Wrappers/Input";
import userService from "@utils/supabase/services/user.service";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "src/store/store";
import { toogleBar } from "src/store/features/walkSlice";

interface IProps {
	initialValues?: Partial<IUserInfo>;
	onChange?: (user: IUserInfo) => void;
}

const currentDate = DateTime.now().toFormat("dd/MM/yyyy");

export default function UserInfo(props: IProps) {
	const colors = useColors();
	const user = useUser().getUserSync();

	const [username, setUsername] = useState(props.initialValues?.username ?? "");
	const [name, setName] = useState(props.initialValues?.name ?? "");
	const [surname, setSurname] = useState(props.initialValues?.surname ?? "");

	const [date, setDate] = useState(props.initialValues?.birthDate ?? currentDate);
	const [selectedIndex, setSelectedIndex] = useState(String(props.initialValues?.gender) ?? String(0));

	const [usernameAvailable, setUsernameAvailable] = useState(true);

	useEffect(() => {
		// if (!usernameAvailable) return;

		const ISODate = DateTime.fromFormat(date, "dd/MM/yyyy").toISODate();

		props.onChange &&
			props.onChange({
				username: usernameAvailable ? username : "",
				name: name,
				surname: surname,
				birthDate: ISODate as any,
				gender: selectedIndex as any,
			});
	}, [name, surname, selectedIndex, date, username]);

	const checkUsernameAvailability = useCallback(async () => {
		if (!username) return;

		setUsername(username.trim());

		setUsernameAvailable((await userService.isUsernameAvailable(username.trim())).data ?? false);
	}, [username]);

	const capitalizeFirstLetter = (text: string) => {
		return text.charAt(0).toUpperCase() + text.slice(1);
	};

	return (
		<View style={{ ...styles.card, paddingHorizontal: 15 }}>
			<Text category="h6" {...props}>
				{i18n.get("firstAccess.steps[1]")}
			</Text>
			<View style={styles.formControl}>
				<Input value={user?.email} label="E-mail" isDisabled />
			</View>

			<View style={styles.formControl}>
				<Input
					w="100%"
					label={i18n.get("firstAccess.userInfo.username")}
					value={username}
					onChangeText={(_) => setUsername(_.replace(/\s/g, ""))}
					cursorColor={colors.primary}
					returnKeyType="next"
					maxLength={16}
					rightElement={<Text style={{ color: colors.text, marginRight: 6 }}>{username.length}/16</Text>}
					onBlur={checkUsernameAvailability}
				/>
			</View>

			<View style={styles.formControl}>
				<Input
					w="47%"
					label={i18n.get("firstAccess.userInfo.name")}
					value={name}
					onChangeText={(_) => setName(capitalizeFirstLetter(_))}
					cursorColor={colors.primary}
					returnKeyType="next"
					maxLength={32}
					rightElement={<Text style={{ color: colors.text, marginRight: 6 }}>{name.length}/32</Text>}
				/>
				<Input
					w="47%"
					label={i18n.get("firstAccess.userInfo.surname")}
					value={surname}
					onChangeText={(_) => setSurname(capitalizeFirstLetter(_))}
					cursorColor={colors.primary}
					returnKeyType="done"
					maxLength={15}
					rightElement={<Text style={{ color: colors.text, marginRight: 6 }}>{surname.length}/15</Text>}
				/>
			</View>

			<View style={styles.formControl}>
				<WrappedSelect
					accessibilityLabel={i18n.get("firstAccess.userInfo.gender")}
					selectedValue={String(selectedIndex)}
					onValueChange={(gender) => {
						setSelectedIndex(String(gender));
					}}
					// value={i18n.get(`firstAccess.userInfo.genders[${selectedIndex.row}]`)}
					minWidth="full"
				>
					<Select.Item label={i18n.get("firstAccess.userInfo.genders[0]")} value="0" />
					<Select.Item label={i18n.get("firstAccess.userInfo.genders[1]")} value="1" />
					<Select.Item label={i18n.get("firstAccess.userInfo.genders[2]")} value="2" />
				</WrappedSelect>
			</View>

			<View style={styles.formControl}>
				{/* <Datepicker
					max={new Date()}
					min={new Date("0000-01-01")}
					
					date={date}
					onSelect={(nextDate) => {
						setDate(nextDate);
					}}
					label={i18n.get("firstAccess.userInfo.birthDate")}
					dateService={localeDateService}
					onBlur={handleInputChange}
					accessoryRight={(porps) => <Ionicons name="calendar" size={24} style={{ color: colors.primary }} {...props} />}
				/> */}

				<MaskedInput
					mask="date"
					label={i18n.get("firstAccess.userInfo.birthDate")}
					value={date}
					w="100%"
					onChangeText={(date) => {
						setDate(date);
					}}
				/>
			</View>
		</View>
	);
}
